class ActionInstancesController < ApplicationController
  before_action :set_action_instance, only: %i[ show update ]

  # GET /action_instances/1 or /action_instances/1.json
  def show
  end

  # PATCH/PUT /action_instances/1 or /action_instances/1.json
  def update
    respond_to do |format|
      if @action_instance.update(action_instance_params)
        format.html { redirect_to @action_instance }
        format.json { render :show, status: :ok, location: @action_instance }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @action_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_action_instance
    @action_instance = ActionInstance.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def action_instance_params
    params.expect(action_instance: [ :progress ])
  end
end
