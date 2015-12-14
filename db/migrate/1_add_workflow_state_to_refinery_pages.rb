class AddWorkflowStateToRefineryPages < ActiveRecord::Migration
  def change
    add_column :refinery_pages, :workflow_state, :string
  end
end