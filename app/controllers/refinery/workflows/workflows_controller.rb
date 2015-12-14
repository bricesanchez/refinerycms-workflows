module Refinery
  module Workflows
    class WorkflowsController < ::ApplicationController

      before_action :find_page, :only => [:create, :new]

      def index
        redirect_to refinery.new_workflows_workflow_path
      end

      def thank_you
        @page = Refinery::Page.where(link_url: "/workflows/thank_you").first
      end

      def new
        @workflow = Workflow.new
      end

      def create
        @workflow = Workflow.new(workflow_params)

        if @workflow.save
          begin
            Mailer.notification(@workflow, request).deliver
          rescue => e
            logger.warn "There was an error delivering the workflow notification.\n#{e.message}\n"
          end

          if Workflow.column_names.map(&:to_s).include?('email')
            begin
              Mailer.confirmation(@workflow, request).deliver
            rescue => e
              logger.warn "There was an error delivering the workflow confirmation:\n#{e.message}\n"
            end
          else
            logger.warn "Please add an 'email' field to Workflow if you wish to send confirmation emails when forms are submitted."
          end

          redirect_to refinery.thank_you_workflows_workflows_path
        else
          render :action => 'new'
        end
      end

      protected

      def find_page
        @page = Refinery::Page.where(link_url: "/workflows/new").first
      end

      private

    # Only allow a trusted parameter "white list" through.
      def workflow_params
        params.require(:workflow).permit(:email)
      end
    end
  end
end
