class QuestionsController < ApplicationController
      
  def update
    @question = Question.find(params[:id])
    if not @question.update(question_params[:question])
      flash[:alert] = "Invalid question"
    else
      flash[:notice] = "Prompt saved"
    end
    @task = @question.question_task
    redirect_back(fallback_location: helpers.task_path(@task))
  end

  def add_option
    @question = Question.find(params[:id])
    if not @question.options.create(option_params[:option])
      flash[:alert] = "Option must not be empty"
    end
    @task = @question.question_task
    redirect_to helpers.task_path(@task.acting_as)
  end

  def edit_scale
    @question = Question.find(params[:id])
    @question.scale.update(scale_params[:scale])
    @task = @question.question_task
    redirect_to helpers.task_path(@task.acting_as)
    flash[:notice] = "Scale saved"
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    @task = @question.question_task
    redirect_to helpers.task_path(@task.acting_as)
  end

  private
    def question_params
      params.permit(question: [:prompt])
    end
    
    def option_params
      params.permit(option: [:contents])
    end

    def scale_params
      params.permit(scale: [:high, :low, :bins])
    end
end
