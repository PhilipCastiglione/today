class RemoveDescriptions < ActiveRecord::Migration[8.0]
  def change
    remove_column :task_templates, :description, :string
    remove_column :task_instances, :description, :string
  end
end
