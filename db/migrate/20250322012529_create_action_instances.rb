class CreateActionInstances < ActiveRecord::Migration[8.0]
  def change
    create_table :action_instances do |t|
      t.references :action_template, null: false, foreign_key: true
      t.references :task_instance, null: false, foreign_key: true
      t.string :description
      t.integer :target
      t.string :target_type
      t.integer :progress

      t.timestamps
    end
  end
end
