module TargetType
  extend ActiveSupport::Concern

  TARGET_TYPES = {
    at_least: "at_least",
    less_than: "less_than"
  }.freeze

  included do
    validates :target_type, inclusion: TARGET_TYPES.values
  end

  class_methods do
    def satisfied?(target, progress)
      case target_type
      when TARGET_TYPES[:at_least]
        progress >= target
      when TARGET_TYPES[:less_than]
        progress < target
      end
    end
  end
end
