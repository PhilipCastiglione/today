class TaskInstancesController < ApplicationController
  before_action :set_task_instance, only: %i[ show update ]

  # GET /task_instances or /task_instances.json
  def index
    @date = params[:date].present? ? Date.parse(params[:date]) : Date.today
    @date = Date.today if @date > Date.today

    @task_instances = if @date == Date.today
      TaskInstance.where(state: [ TaskInstance::STATES[:active], TaskInstance::STATES[:completed] ], completed_at: [ nil, @date ])
        .or(TaskInstance.where(state: TaskInstance::STATES[:skipped], due_date: @date))
        .includes(:task_template, :action_instances)
    else
      TaskInstance.where(completed_at: @date)
        .or(TaskInstance.where(completed_at: nil, due_date: @date))
        .includes(:task_template, :action_instances)
    end.sort_by { |ti| [ ti.state, ti.task_template.task_category.sort_order, ti.due_date, ti.created_at ] }
  end

  # GET /task_instances/1 or /task_instances/1.json
  def show
  end

  # PATCH/PUT /task_instances/1 or /task_instances/1.json
  def update
    respond_to do |format|
      if @task_instance.update(task_instance_params)
        format.html { redirect_to @task_instance }
        format.json { render :show, status: :ok, location: @task_instance }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task_instance
    @task_instance = TaskInstance.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def task_instance_params
    params.expect(task_instance: [ :state, :due_date ])
  end
end
