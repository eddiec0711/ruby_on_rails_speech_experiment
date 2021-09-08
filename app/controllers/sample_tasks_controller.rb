class SampleTasksController < TasksController
  def self.controller_path
    'tasks/sample_tasks'
  end

  def new
    @task = SampleTask.new
    super
  end
    
  def create
    @task = SampleTask.new(sample_task_params[:task])
    super
  end
  
  def update
    @task_params = sample_task_params[:task]
    super
  end

  def upload_audio
    @task = SampleTask.find(params[:id])
    file = sample_task_params[:task][:audio]
    if file.size < 314572800
      if @task.audio.attached?
        @task.audio.purge
      end
      @task.audio.attach(file)
      redirect_to helpers.task_path(@task.acting_as)
    else
      @audioError = "File size must not exceed 300 megabytes"
      render 'show'
    end
  end

  def upload_transcript
    @task = SampleTask.find(params[:id])
    file = sample_task_params[:task][:transcript]
    if file.size < 314572800
      if @task.transcript.attached?
        @task.transcript.purge
      end
      @task.transcript.attach(file)
      redirect_to helpers.task_path(@task.acting_as)
    else
      @transcriptError = "File size must not exceed 300 megabytes"
      render 'show'
    end
  end

  def destroy_audio
    @task = SampleTask.find(params[:id])
    @task.audio.purge
    redirect_to helpers.task_path(@task.acting_as)
  end

  def destroy_transcript
    @task = SampleTask.find(params[:id])
    @task.transcript.purge
    redirect_to helpers.task_path(@task.acting_as)
  end

  def calibration
    @task = SampleTask.find(params[:id])
    @task.update(sample_task_params[:task])
  end

  private
    def sample_task_params
      params.permit({task: [:name, :audio, :transcript, :random, :calibration]}, :taskable_id, :taskable_type)
    end
end