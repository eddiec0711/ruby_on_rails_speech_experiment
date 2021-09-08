class TasksController < ApplicationController

  def show
    @task = Task.find(params[:id]).specific
  end

  def new
    @task = @task.acting_as
    render 'tasks/shared/new'
  end
    
  def create
    if params[:taskable_type] == 'Experiment'
      create_experiment_task
    else
      create_task_task
    end
  end

  def create_experiment_task
    @taskable = current_user.experiments.find(params[:taskable_id])
    if @taskable.tasks << @task
      redirect_to @taskable
    else
      flash[:alert] = "Name must not be empty"
      render 'tasks/shared/new'
    end
  end

  def create_task_task
    @taskable = Task.find_by(actable_id: params[:taskable_id], actable_type: params[:taskable_type])
    if @taskable.specific.tasks << @task
      redirect_to helpers.task_path(@taskable)
    else
      flash[:alert] = "Name must not be empty"
      render 'tasks/shared/new'
    end
  end
      
  def edit
    @task = Task.find(params[:id]).specific
  end
  
  def update
    @task = Task.find(params[:id])
    if @task.update(@task_params)
      redirect_to helpers.task_path(@task)
      flash[:notice] = "Name changed"
    else
      flash[:alert] = "Name must not be empty"
      redirect_to helpers.task_path(@task)
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to helpers.taskable_path(@task.taskable)
  end

  def random
    @task = Task.find(params[:id])
    @task.update(random_params)
  end

  private
    def random_params
      params.require(:task).permit(:random)
    end
end
