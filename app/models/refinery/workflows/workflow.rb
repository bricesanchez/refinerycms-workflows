
module Refinery
  module Workflows
    class Workflow < Refinery::Core::BaseModel
      self.table_name = 'refinery_workflows'



      # def message was created automatically because you didn't specify a text field
      # when you ran the refinery:form generator. <3 <3 Refinery CMS.
      def message
        "Override def message in vendor/extensions/workflows/app/models/refinery/workflows/workflow.rb"
      end

      alias_attribute :name, :email

      # Add some validation here if you want to validate the user's input
      # We have validated the first string field for you.
      validates :email, :presence => true
    end
  end
end
