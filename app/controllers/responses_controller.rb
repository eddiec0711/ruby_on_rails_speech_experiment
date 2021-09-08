class ResponsesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :check_experiment

  def index
    @experiment = Experiment.find_by(slug: params[:slug])
    @participant_id = @experiment.tasks.first.visits.maximum(:participant_id).to_i + 1
    @experiment.tasks.map {|t| t.visits.create(participant_id: @participant_id)}
  end

  def show    
    @experiment = Experiment.find_by(slug: params[:slug])
    @sample = SampleTask.find(params[:sample_id])
    @sample.tasks.map {|t| t.visits.create(participant_id: params[:participant_id])}
  end

  def new
    @experiment = Experiment.find_by(slug: params[:slug])
    @task = Task.find_by(actable_id: params[:actable_id], actable_type: params[:actable_type]).specific
    if @task.taskable_type == 'SampleTask'
      @sample = SampleTask.find_by(id: @task.taskable_id)
      if @sample.transcript.attached?
        @transcript = @sample.transcript.download
      else
        @transcript = "none"
      end
    end 
    @task.visit(params[:participant_id])
    @participant_id = params[:participant_id]
    @address = Rails.application.config.app_url
    @token = session[:_csrf_token]
  end

  def create
    experiment = Experiment.find_by(slug: params[:slug])
    task = Task.find_by(actable_id: params[:actable_id], actable_type: params[:actable_type])
    responses = responses_params.values.collect {|r| r[:response]}
    if Response.create(responses)
      redirect_to helpers.next_task(task.taskable, params[:participant_id])
    else 
      render :action => :new
    end
  end

  def finish
  end 

  private
    def responses_params
      params.require(:responses).each do |k, v|
        v[:response] = params[:responses][k][:response].permit(:answer, :participant_id, :question_id, answer:[])
      end
    end

    def check_experiment
      experiment = Experiment.find_by(slug: params[:slug])
      unless experiment.complete
        flash[:alert] = "Experiment is not published yet"
        redirect_to root_path
      end
    end 
end
