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

      config.after_initialize do
        Refinery.register_extension(Refinery::Workflows)
      end
    end
  end
end
