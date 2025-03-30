module GoalType
  extend ActiveSupport::Concern

  GOAL_TYPES = {
    all: "all",
    one: "one"
  }.freeze

  included do
    validates :goal_type, inclusion: GOAL_TYPES.values
  end
end
