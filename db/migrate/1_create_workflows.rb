class CreateWorkflows < ActiveRecord::Migration

  def up
    create_table :refinery_workflows do |t|
      t.string :email

     t.timestamps
    end

    add_index :refinery_workflows, :id
  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "workflows"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/workflows"})
    end

    drop_table :refinery_workflows
  end

end
