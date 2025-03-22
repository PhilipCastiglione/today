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
require "test_helper"

class ActionInstanceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
