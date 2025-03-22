# == Schema Information
#
# Table name: task_instances
#
#  id               :integer          not null, primary key
#  description      :string
#  due_date         :date
#  goal_type        :string
#  reminder_time    :string
#  start_date       :date
#  state            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  task_template_id :integer          not null
#
# Indexes
#
#  index_task_instances_on_task_template_id  (task_template_id)
#
# Foreign Keys
#
#  task_template_id  (task_template_id => task_templates.id)
#
class TaskInstance < ApplicationRecord
  belongs_to :task_template

  has_many :action_instances
end
