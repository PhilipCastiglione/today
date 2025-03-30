if ENV["TRUNCATE"].present?
  puts("Deleting all data:")

  Rails.application.eager_load!

  ApplicationRecord.descendants.each do |model|
    puts("  - Deleting #{model.name}")
    model.destroy_all
  end

  puts("\n")
end

if ENV["SKIP_SEED"].present?
  puts("Skipping seeding database")
  exit(0)
end

puts("Seeding database")

email_address = Rails.application.credentials.dig(:user, :email)

unless User.exists?(email_address: email_address)
  puts("Seeding user")
  user = User.new(email_address: email_address)

  password = Rails.application.credentials.dig(:user, :password)
  user.password = password
  user.password_confirmation = password

  user.save!
end

if Rails.env.development?
  TaskTemplate.create!(
    # active: true,
    first_date: Date.today,
    # end_date: Date.today + 30.days,
    days_to_complete: 1,
    repeat_days: 1,
    # reminder_time: "08:00",
    goal_type: GoalType::GOAL_TYPES[:all],
    task_category_id: TaskCategory::TASK_CATEGORY_IDS[:grooming],
    action_templates: [
      ActionTemplate.new(
        description: "Brush twice",
        target: 2,
        target_type: TargetType::TARGET_TYPES[:at_least],
      ),
      ActionTemplate.new(
        description: "Floss",
        target: 1,
        target_type: TargetType::TARGET_TYPES[:at_least],
      )
    ]
  )

  TaskTemplate.create!(
    # active: true,
    first_date: Date.today,
    # end_date: Date.today + 30.days,
    days_to_complete: 2,
    repeat_days: 6,
    # reminder_time: "08:00",
    goal_type: GoalType::GOAL_TYPES[:all],
    task_category_id: TaskCategory::TASK_CATEGORY_IDS[:chores],
    action_templates: [
      ActionTemplate.new(
        description: "Vacuum upstairs",
        target: 1,
        target_type: TargetType::TARGET_TYPES[:at_least],
      ),
      ActionTemplate.new(
        description: "Vacuum downstairs",
        target: 1,
        target_type: TargetType::TARGET_TYPES[:at_least],
      )
    ]
  )

  TaskTemplate.create!(
    active: false,
    first_date: Date.today,
    # end_date: Date.today + 30.days,
    days_to_complete: 1,
    repeat_days: 1,
    # reminder_time: "08:00",
    goal_type: GoalType::GOAL_TYPES[:all],
    task_category_id: TaskCategory::TASK_CATEGORY_IDS[:physical],
    action_templates: [
      ActionTemplate.new(
        description: "Do thing",
        target: 10,
        target_type: TargetType::TARGET_TYPES[:at_least],
      )
    ]
  )

  previous_task_template = TaskTemplate.create!(
    active: false,
    first_date: Date.today - 7.days,
    end_date: Date.today - 1.day,
    days_to_complete: 1,
    repeat_days: 1,
    # reminder_time: "08:00",
    goal_type: GoalType::GOAL_TYPES[:all],
    task_category_id: TaskCategory::TASK_CATEGORY_IDS[:physical],
    action_templates: [
      ActionTemplate.new(
        description: "Do thing previously",
        target: 10,
        target_type: TargetType::TARGET_TYPES[:at_least],
      )
    ]
  )
  TaskInstance.create!(
    task_template: previous_task_template,
    start_date: previous_task_template.first_date,
    due_date: previous_task_template.first_date + previous_task_template.days_to_complete.days,
    goal_type: previous_task_template.goal_type,
    state: TaskInstance::STATES[:completed],
    action_instances: previous_task_template.action_templates.map(&:new_instance).tap do |action_instances|
      action_instances.each { |ai| ai.update(progress: ai.target) }
    end
  )

  TaskTemplate.create!(
    active: false,
    first_date: Date.today + 7.days,
    # end_date: Date.today + 30.days,
    days_to_complete: 1,
    repeat_days: 1,
    # reminder_time: "08:00",
    goal_type: GoalType::GOAL_TYPES[:all],
    task_category_id: TaskCategory::TASK_CATEGORY_IDS[:physical],
    action_templates: [
      ActionTemplate.new(
        description: "Do future thing",
        target: 10,
        target_type: TargetType::TARGET_TYPES[:at_least],
      )
    ]
  )

  TaskTemplate.create!(
    # active: true,
    first_date: Date.today,
    end_date: Date.today + 29.days,
    days_to_complete: 1,
    repeat_days: 1,
    # reminder_time: "08:00",
    goal_type: GoalType::GOAL_TYPES[:all],
    task_category_id: TaskCategory::TASK_CATEGORY_IDS[:physical],
    action_templates: [
      ActionTemplate.new(
        description: "Pushups",
        target: 20,
        target_type: TargetType::TARGET_TYPES[:at_least],
      )
    ]
  )

  TaskTemplate.create!(
    # active: true,
    first_date: Date.today,
    # end_date: Date.today + 30.days,
    days_to_complete: 2,
    repeat_days: 3,
    # reminder_time: "08:00",
    goal_type: GoalType::GOAL_TYPES[:all],
    task_category_id: TaskCategory::TASK_CATEGORY_IDS[:grooming],
    action_templates: [
      ActionTemplate.new(
        description: "Trim Beard",
        target: 1,
        target_type: TargetType::TARGET_TYPES[:at_least],
      )
    ]
  )

  TaskTemplate.create!(
    # active: true,
    first_date: Date.today,
    # end_date: Date.today + 30.days,
    days_to_complete: 1,
    repeat_days: 1,
    reminder_time: "12:00",
    goal_type: GoalType::GOAL_TYPES[:all],
    task_category_id: TaskCategory::TASK_CATEGORY_IDS[:health],
    action_templates: [
      ActionTemplate.new(
        description: "Take multivitamin",
        target: 1,
        target_type: TargetType::TARGET_TYPES[:at_least],
      ),
      ActionTemplate.new(
        description: "Take single vitamin",
        target: 1,
        target_type: TargetType::TARGET_TYPES[:at_least],
      )
    ]
  )

  TaskTemplate.create!(
    # active: true,
    first_date: Date.today,
    # end_date: Date.today + 30.days,
    days_to_complete: 1,
    repeat_days: 1,
    # reminder_time: "08:00",
    goal_type: GoalType::GOAL_TYPES[:one],
    task_category_id: TaskCategory::TASK_CATEGORY_IDS[:physical],
    action_templates: [
      ActionTemplate.new(
        description: "This",
        target: 1,
        target_type: TargetType::TARGET_TYPES[:at_least],
      ),
      ActionTemplate.new(
        description: "That",
        target: 1,
        target_type: TargetType::TARGET_TYPES[:at_least],
      )
    ]
  )

  TaskTemplate.create!(
    # active: true,
    first_date: Date.today,
    # end_date: Date.today + 30.days,
    days_to_complete: 1,
    repeat_days: 1,
    # reminder_time: "08:00",
    goal_type: GoalType::GOAL_TYPES[:all],
    task_category_id: TaskCategory::TASK_CATEGORY_IDS[:critical],
    action_templates: [
      ActionTemplate.new(
        description: "Do thing!!!",
        target: 1,
        target_type: TargetType::TARGET_TYPES[:at_least],
      )
    ]
  )

  TaskTemplate.create!(
    # active: true,
    first_date: Date.today,
    # end_date: Date.today + 30.days,
    days_to_complete: 3,
    # repeat_days: 1,
    # reminder_time: "08:00",
    goal_type: GoalType::GOAL_TYPES[:all],
    task_category_id: TaskCategory::TASK_CATEGORY_IDS[:ad_hoc],
    action_templates: [
      ActionTemplate.new(
        description: "Do thing once",
        target: 1,
        target_type: TargetType::TARGET_TYPES[:at_least],
      )
    ]
  )

  TaskTemplate.create!(
    # active: true,
    first_date: Date.today,
    # end_date: Date.today + 30.days,
    days_to_complete: 1,
    repeat_days: 1,
    # reminder_time: "08:00",
    goal_type: GoalType::GOAL_TYPES[:all],
    task_category_id: TaskCategory::TASK_CATEGORY_IDS[:mental],
    action_templates: [
      ActionTemplate.new(
        description: "Scratch itch less than 5 times",
        target: 5,
        target_type: TargetType::TARGET_TYPES[:less_than],
      )
    ]
  )

  TomorrowJob.perform_now

  puts("")
  puts("Created data:")
  ApplicationRecord.descendants.each do |model|
    puts("  - #{model.name} count: #{model.count}")
  end
end
