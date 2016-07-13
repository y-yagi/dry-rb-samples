require 'dry-types'

module Types
  include Dry::Types.module

  Email = String.constrained(format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
  Age = Int.constrained(gt: 18)
end

class User < Dry::Types::Struct
  attribute :name, Types::String
  attribute :email, Types::Email
  attribute :age, Types::Age
end

#User.new(name: 'tommy', email: 'tommy@example.com', age: 10)

class Book < Dry::Types::Struct
  Statuses = Types::Strict::String.enum('draft', 'published', 'archived')

  attribute :id, Types::Maybe::Coercible::Int
  attribute :status, Statuses
#  attribute :comments, Types::Strict::Array.member(Types::Strict::String)
#  attribute :status, Types::Coercible::String.default('draft')
#  attribute :name, Types::Coercible::String.constrained(min_size: 3, max_size: 9)
end
puts Book.new(id: 1, status: 'published').status
puts Book.new(id: 1, status: 1).status

puts Book.new(id: 1, status: 'out').status
puts Book.new(id: 1, status: 3).status
