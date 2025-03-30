class TomorrowJob < ApplicationJob
  queue_as :default

  retry_on StandardError

  def perform
    # TODO: implement
    # find active task instances and
    # - update_state
    # find active task templates and
    # - next_instance on the template
    active_task_instances = TaskInstance.where(state: TaskInstance::STATES[:active])
    active_task_instances.each(&:update_state)

    active_task_templates = TaskTemplate.where(active: true)
    active_task_templates.each(&:next_instance)
  end
end
