require 'dry-container'
require 'dry-auto_inject'
require 'byebug'

class DataStore
  attr_accessor :users

  def initialize
    @users = []
  end
end

my_container = Dry::Container.new

my_container.register("data_store", -> { DataStore.new })
my_container.register("user_repository", -> { my_container["data_store"].users })
my_container.register("persist_user", -> { PersistUser.new })

# set up your auto-injection function
AutoInject = Dry::AutoInject(my_container)

# then simply include it in your class providing which dependencies should be
# injected automatically from the configured container
class PersistUser
  include AutoInject["user_repository"]

  def call(user)
    user_repository << user
  end
end

persist_user = my_container["persist_user"]
persist_user.call(name: 'Jane')
