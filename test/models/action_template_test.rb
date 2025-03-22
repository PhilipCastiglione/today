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
require "test_helper"

class ActionTemplateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
