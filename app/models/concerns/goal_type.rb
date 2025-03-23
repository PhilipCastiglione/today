module GoalType
  extend ActiveSupport::Concern

  GOAL_TYPES = {
    all: "all",
    one: "one"
  }.freeze

  included do
    validates :goal_type, inclusion: GOAL_TYPES.values
  end

  class_methods do
    def satisfied?(action_instances)
      case goal_type
      when GOAL_TYPES[:all]
        action_instances.all?(&:completed?)
      when GOAL_TYPES[:one]
        action_instances.any?(&:completed?)
      end
    end
  end
end
