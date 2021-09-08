class ExperimentsController < ApplicationController

  def index
    @current_nav_identifier = 'experiments'
    @experiments = current_user.experiments
  end
  
  def show
    @experiment = current_user.experiments.find(params[:id])
    @total_responses = @experiment.total_responses
    @fully_finished = @experiment.finished_responses
    @last_response = @experiment.last_response_date
  end

  def new
    @experiment = Experiment.new
  end
  
  def edit
    @experiment = current_user.experiments.find(params[:id])
  end
  
  def terms
    @experiment = current_user.experiments.find(params[:id])
  end

  def complete
    @experiment = current_user.experiments.find(params[:id])
    if params[:force] == '1'
      @experiment.complete = true
      @experiment.save
      redirect_to @experiment
    else
      @experiment_errors = @experiment.completion_errors
      if @experiment_errors[:warnings].empty? and @experiment_errors[:errors].empty?
        @experiment.complete = true
        @experiment.save
        redirect_to @experiment
      else
        render 'show'
      end
    end
  end

  def create
    @experiment = current_user.experiments.build(experiment_params[:experiment])
    if @experiment.save
      redirect_to @experiment
    else
      render 'new'
    end
  end

  def update
    @experiment = current_user.experiments.find(params[:id])

    if @experiment.update(experiment_params[:experiment])
        redirect_to @experiment
    else
        render 'edit'
    end
  end

  def update_terms
    @experiment = current_user.experiments.find(params[:id])

    if @experiment.update(experiment_params[:experiment])
        redirect_to @experiment
    else
        render 'terms'
    end
  end

  def destroy
    @experiment = current_user.experiments.find(params[:id])
    @experiment.destroy
    redirect_to experiments_path
  end

  def download
    @experiment = current_user.experiments.find(params[:id])
    if @experiment.complete
      @download_experiment = helpers.decorate(@experiment, ExperimentDownloadDecorator)
      @download_experiment.generate_results
      redirect_to rails_blob_path(@experiment.results, disposition: "attachment")
    else
      flash[:alert] = 'experiment not complete'
      redirect_to @experiment
    end
  end

  private
    def experiment_params
      params.permit(experiment: [:name, :description, :terms])
    end
end