module TargetType
  extend ActiveSupport::Concern

  TARGET_TYPES = {
    at_least: "at_least",
    less_than: "less_than"
  }.freeze

  included do
    validates :target_type, inclusion: TARGET_TYPES.values
  end
end
