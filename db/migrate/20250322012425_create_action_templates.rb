class CreateActionTemplates < ActiveRecord::Migration[8.0]
  def change
    create_table :action_templates do |t|
      t.references :task_template, null: false, foreign_key: true
      t.string :description
      t.integer :target
      t.string :target_type

      t.timestamps
    end
  end
end
