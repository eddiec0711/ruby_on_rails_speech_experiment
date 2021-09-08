class ClickTasksController < TasksController

  def self.controller_path
    'tasks/click_tasks'
  end

  def new
    @task = ClickTask.new
    super
  end

  def create
    @task = ClickTask.new(click_task_params[:task])
    super
  end

  def update
    @task_params = click_task_params[:task]
    super
  end

  def update_prompt
    @task = ClickTask.find(params[:id])
    @task.update(click_task_params[:task])
    @task.save!
    redirect_to helpers.task_path(@task.acting_as)
  end

  private
    def click_task_params
      params.permit({task: [:name, :prompt, :random]}, :taskable_id, :taskable_type)
    end
end
