class TaskTemplatesController < ApplicationController
  before_action :set_task_template, only: %i[ show update destroy ]

  # GET /task_templates or /task_templates.json
  def index
    @task_templates = TaskTemplate.all.order(active: :desc)
  end

  # GET /task_templates/1 or /task_templates/1.json
  def show
  end

  # GET /task_templates/new
  def new
    @task_template = TaskTemplate.new
  end

  # POST /task_templates or /task_templates.json
  def create
    @task_template = TaskTemplate.new(task_template_params)

    respond_to do |format|
      if @task_template.save
        format.html { redirect_to @task_template }
        format.json { render :show, status: :created, location: @task_template }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_templates/1 or /task_templates/1.json
  def update
    respond_to do |format|
      if @task_template.update(task_template_params)
        format.html { redirect_to @task_template }
        format.json { render :show, status: :ok, location: @task_template }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_templates/1 or /task_templates/1.json
  def destroy
    @task_template.destroy!

    respond_to do |format|
      format.html { render :show, status: :ok, location: @task_template }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task_template
    @task_template = TaskTemplate.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def task_template_params
    params.expect(task_template: [ :active, :first_date, :end_date, :days_to_complete, :repeat_days, :goal_type ])
  end
end
