# == Schema Information
#
# Table name: task_templates
#
#  id               :integer          not null, primary key
#  active           :boolean          default(TRUE)
#  days_to_complete :integer
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
  include TaskCategory
  include GoalType

  has_many :task_instances
  has_many :action_templates

  validates_presence_of :description
  validates_presence_of :end_date
  validates_presence_of :first_date
  validates_numericality_of :repeat_days, greater_than_or_equal_to: 1, allow_nil: true
  validates_numericality_of :days_to_complete, greater_than_or_equal_to: 1
  validate :one_or_more_action_templates

  def repeats?
    repeat_days.present?
  end

  def next_instance
    most_recent_instance = task_instances.order(:created_at).last

    error_instance = TaskInstance.new

    if most_recent_instance&.state == TaskInstance::STATES[:active]
      error_instance.errors.add(:base, "Cannot create a new instance while the most recent instance is active")
    end

    if most_recent_instance.present? && !repeats?
      error_instance.errors.add(:base, "Cannot create another instance for a non-repeating task")
    end

    start_date = if most_recent_instance.nil?
      first_date > Date.today ? first_date : Date.today
    else
      most_recent_instance.completed_at + repeat_days.days
    end

    if start_date > end_date
      error_instance.errors.add(:base, "Cannot create another instance after the end date")
    end

    return error_instance if error_instance.errors.any?

    task_instances.create(
      task_template: self,
      description: description,
      start_date: start_date,
      due_date: start_date + days_to_complete.days,
      goal_type: goal_type,
      reminder_time: reminder_time,
      state: TaskInstance::STATES[:active],
      action_instances: action_templates.map(&:new_instance)
    )
  end

  private

  def one_or_more_action_templates
    errors.add(:base, "Task template must have at least one action template") if action_templates.empty?
  end
end
