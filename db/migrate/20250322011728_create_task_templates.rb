class CreateTaskTemplates < ActiveRecord::Migration[8.0]
  def change
    create_table :task_templates do |t|
      t.date :first_date
      t.date :end_date
      t.string :description
      t.integer :repeat_days
      t.boolean :active
      t.string :reminder_time
      t.string :task_category_id

      t.timestamps
    end
  end
end
