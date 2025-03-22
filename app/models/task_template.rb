# == Schema Information
#
# Table name: task_templates
#
#  id               :integer          not null, primary key
#  active           :boolean
#  description      :string
#  end_date         :date
#  first_date       :date
#  goal_type        :string
#  reminder_time    :string
#  repeat_days      :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  task_category_id :string
#
class TaskTemplate < ApplicationRecord
  has_many :task_instances
  has_many :action_templates
end
