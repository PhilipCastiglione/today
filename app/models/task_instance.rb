# == Schema Information
#
# Table name: task_instances
#
#  id               :integer          not null, primary key
#  completed_at     :date
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
  include GoalType

  belongs_to :task_template
  has_many :action_instances

  STATES = {
    active: "active",
    skipped: "skipped",
    completed: "completed",
    failed: "failed"
  }.freeze

  validates_presence_of :description
  validates_presence_of :start_date
  validates_presence_of :due_date
  validates :state, inclusion: STATES.values
  validates :one_or_more_action_instances

  STATES.each do |state, _|
    define_method("#{state}?") do
      self.state == state
    end
  end

  def skip
    update(state: STATES[:skipped])
  end

  def update_state
    completed_date = Date.today > due_date ? due_date : Date.today
    case state
    when STATES[:active]
      if satisfied?(action_instances)
        update(state: STATES[:completed], completed_at: completed_date)
      elsif Date.today > due_date
        update(state: STATES[:failed], completed_at: nil)
      end
    when STATES[:skipped]
      if satisfied?(action_instances)
        update(state: STATES[:completed], completed_at: completed_date)
      end
    when STATES[:completed]
      if !satisfied?(action_instances)
        if Date.today > due_date
          update(state: STATES[:failed], completed_at: nil)
        else
          update(state: STATES[:active], completed_at: nil)
        end
      end
    when STATES[:failed]
      if satisfied?(action_instances)
        update(state: STATES[:completed], completed_at: completed_date)
      elsif Date.today <= due_date
        update(state: STATES[:active], completed_at: nil)
      end
    end
  end

  private

  def one_or_more_action_instances
    errors.add(:base, "Task instance must have at least one action instance") if action_instances.empty?
  end
end
