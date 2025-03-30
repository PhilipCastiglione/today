module TaskCategory
  extend ActiveSupport::Concern

  class TaskCategoryDetail
    attr_reader :id, :label, :sort_order, :color

    def initialize(id, label, sort_order, color)
      @id = id
      @label = label
      @sort_order = sort_order
      @color = color
    end
  end

  TASK_CATEGORIES = [
    TaskCategoryDetail.new("critical", "CRITICAL", 0, "red"),
    TaskCategoryDetail.new("ad_hoc",   "AD HOC",   1, "brown"),
    TaskCategoryDetail.new("physical", "PHYSICAL", 2, "purple"),
    TaskCategoryDetail.new("grooming", "GROOMING", 3, "yellow"),
    TaskCategoryDetail.new("health",   "HEALTH",   4, "green"),
    TaskCategoryDetail.new("chores",   "CHORES",   5, "orange"),
    TaskCategoryDetail.new("mental",   "MENTAL",   6, "blue")
  ].freeze

  TASK_CATEGORY_IDS = TASK_CATEGORIES.inject({}) do |hash, tc|
    hash[tc.id.to_sym] = tc.id
    hash
  end.freeze

  included do
    validates :task_category_id, inclusion: TASK_CATEGORY_IDS.values

    def task_category
      @task_category ||= TASK_CATEGORIES.find { |tc| tc.id == task_category_id }
    end
  end
end
