require 'dry-initializer'
require 'dry-types'

module Types
   include Dry::Types.module
end

class User
  extend Dry::Initializer::Mixin

  param  :name,  type: Types::Coercible::String
  param  :role,  default: proc { 'customer' }
  option :admin, default: proc { false }
end

user = User.new 'Vladimir', 'admin', admin: true

user.name  # => 'Vladimir'
user.role  # => 'admin'
user.admin # => true
