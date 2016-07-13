require 'dry-monads'

class EitherCalculator
  include Dry::Monads::Either::Mixin

  attr_accessor :input

  def calculate
    i = Integer(input)

    Right(i).bind do |value|
      if value > 1
        Right(value + 3)
      else
        Left("value was less than 1")
      end
    end.bind do |value|
      if value % 2 == 0
        Right(value * 2)
      else
        Left("value was not even")
      end
    end
  end
end

c = EitherCalculator.new

c.input = 3
result = c.calculate
puts result # => Right(12)
puts result.value # => 12

c.input = 0
result = c.calculate
puts result # => Left("value was less than 1")
puts result.value # => "value was less than 1"

c.input = 2
result = c.calculate
puts result # => Left("value was not even")
puts result.value # => "value was not even"
