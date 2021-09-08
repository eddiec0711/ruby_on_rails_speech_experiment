class ListeningTasksController < TasksController

  def self.controller_path
    'tasks/listening_tasks'
  end

  def new
    @task = ListeningTask.new
    super
  end

  def create
    @task = ListeningTask.new(listening_task_params[:task])
    super
  end

  def update
    @task_params = listening_task_params[:task]
    super
  end

  def update_listens
    @task = ListeningTask.find(params[:id])
    @task.update(listening_task_params[:task])
    @task.save!
    redirect_to helpers.task_path(@task.acting_as)
  end

  private
    def listening_task_params
      params.permit({task: [:name, :listens, :random]}, :taskable_id, :taskable_type)
    end
end
