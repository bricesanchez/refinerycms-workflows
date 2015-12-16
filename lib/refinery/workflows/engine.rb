module Refinery
  module Workflows
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::Workflows

      engine_name :refinery_workflows

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "workflows"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.workflows_admin_workflows_path }
          plugin.pathname = root

        end
      end

      # config.to_prepare do
      #   Decorators.register! ::Refinery::Workflows.root
      # end

      def self.activate
        Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
          Rails.configuration.cache_classes ? require(c) : load(c)
        end
      end

      config.to_prepare &method(:activate).to_proc

      config.after_initialize do
        Refinery.register_extension(Refinery::Workflows)
      end
    end
  end
end
