# == Schema Information
#
# Table name: action_instances
#
#  id                 :integer          not null, primary key
#  description        :string
#  progress           :integer
#  target             :integer
#  target_type        :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  action_template_id :integer          not null
#  task_instance_id   :integer          not null
#
# Indexes
#
#  index_action_instances_on_action_template_id  (action_template_id)
#  index_action_instances_on_task_instance_id    (task_instance_id)
#
# Foreign Keys
#
#  action_template_id  (action_template_id => action_templates.id)
#  task_instance_id    (task_instance_id => task_instances.id)
#
class ActionInstance < ApplicationRecord
  include TargetType

  belongs_to :action_template
  belongs_to :task_instance

  validates_presence_of :description
  validates_numericality_of :target, greater_than_or_equal_to: 0
  validates_numericality_of :progress, greater_than_or_equal_to: 0

  def set_progress(progress)
    self.progress = progress
    task_instance.update_state if save
    self
  end

  def completed?
    satisfied?(target, progress)
  end
end
