module Refinery
  module Workflows
    module Admin
      class WorkflowsController < Refinery::AdminController

        crudify :'refinery/workflows/workflow', 
                :title_attribute => "email", 
                :order => "created_at DESC"

        def index
          if searching?
            search_all_workflows
          else
            find_all_workflows
          end

          @grouped_workflows = group_by_date(@workflows)
        end


        private

        # Only allow a trusted parameter "white list" through.
        def workflow_params
          params.require(:workflow).permit(:email)
        end
      end
    end
  end
end
