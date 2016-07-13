require 'dry/component/container'

class Application < Dry::Component::Container
  configure do |config|
    config.root = Pathname.new('app')

    config.auto_register = 'lib'
  end

  load_paths!('lib')
end


Application.finalize!
Application['my_logger']
