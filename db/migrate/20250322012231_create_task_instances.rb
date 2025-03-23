class CreateTaskInstances < ActiveRecord::Migration[8.0]
  def change
    create_table :task_instances do |t|
      t.string :state
      t.date :start_date
      t.date :due_date
      t.date :completed_at
      t.string :description
      t.string :reminder_time
      t.references :task_template, null: false, foreign_key: true
      t.string :goal_type

      t.timestamps
    end
  end
end
