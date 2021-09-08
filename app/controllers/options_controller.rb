class OptionsController < ApplicationController

  def create
  end

  def destroy
    update_headers_to_disable_caching
    @option = Option.find(params[:id])
    @option.destroy
    @task = @option.chooseable.question_task
    redirect_back(fallback_location: helpers.task_path(@task))
  end
end