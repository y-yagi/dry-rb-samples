require 'dry-monads'

class Address
  attr_accessor :street

  def initialize(street)
    @street = street
  end
end

class User
  attr_accessor :address

  def initialize(address)
    @address = address
  end
end

user = User.new(Address.new('Street Address'))

M = Dry::Monads
maybe_user = M.Maybe(user).bind do |u|
  M.Maybe(user.address).bind do |a|
    M.Maybe(a.street)
  end
end
puts maybe_user.value

