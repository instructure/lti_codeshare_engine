module LtiCodeshareEngine
  class Engine < ::Rails::Engine
    isolate_namespace LtiCodeshareEngine

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
