require 'dry-transaction'
require 'dry-container'
require 'dry-monads'

class Container
  extend Dry::Container::Mixin

  register :process, -> input {
    Dry::Monads.Right(name: input["name"], email: input["email"])
  }

  register :validate, -> input {
    p input
    input[:email].nil? ? Dry::Monads.Left(:not_valid) : Dry::Monads.Right(input)
  }

  register :persist, -> input {
    DB << input; Dry::Monads.Right(input)
  }
end


save_user = Dry.Transaction(container: Container) do
  step :process
  step :validate
  step :persist
end

DB = []
# result = save_user.call("name" => "Jane", "email" => "jane@doe.com")
# p result.class
# p save_user.call("name" => "Jane")

save_user.call("name" => "Jane", "email" => "jane@doe.com") do |m|
  m.success do |value|
    puts "Succeeded!"
  end

  m.failure :validate do |error|
    # `validate`ステップで失敗
    puts "Please provide a valid user."
  end

  m.failure do |error|
    # 何処かのステップで失敗
    puts "Couldn’t save this user."
  end
end

