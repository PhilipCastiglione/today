# == Schema Information
#
# Table name: action_templates
#
#  id               :integer          not null, primary key
#  description      :string
#  target           :integer
#  target_type      :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  task_template_id :integer          not null
#
# Indexes
#
#  index_action_templates_on_task_template_id  (task_template_id)
#
# Foreign Keys
#
#  task_template_id  (task_template_id => task_templates.id)
#
class ActionTemplate < ApplicationRecord
  include TargetType

  belongs_to :task_template
  has_many :action_instances

  validates_presence_of :description
  validates_numericality_of :target, greater_than_or_equal_to: 0

  def new_instance
    action_instances.new(
      action_template: self,
      description: description,
      target: target,
      target_type: target_type,
      progress: 0
    )
  end
end
