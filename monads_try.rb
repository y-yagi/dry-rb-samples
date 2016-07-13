require 'dry-monads'

module ExceptionalLand
  extend Dry::Monads::Try::Mixin

  res = Try() { 10 / 2 }
  res.value if res.success?
  p res.class
  # => 5

  res = Try() { 10 / 0 }
  res.exception if res.failure?
  # => #<ZeroDivisionError: divided by 0>
  p res.class

  # By default Try catches all exceptions inherited from StandardError.
  # However you can catch only certain exceptions like this
  Try(NoMethodError, NotImplementedError) { 10 / 0 }
  # => raised ZeroDivisionError: divided by 0 exception
end
