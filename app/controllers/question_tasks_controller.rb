class QuestionTasksController < TasksController
  
  def self.controller_path
    'tasks/question_tasks'
  end

  def new
    @task = QuestionTask.new
    super
  end
    
  def create
    @task = QuestionTask.new(question_task_params[:task])
    super
  end
  
  def update
    @task_params = question_task_params[:task]
    super
  end

  def add_question
    @task = QuestionTask.find(params[:id])
    case params[:type]
    when 'text'
      question = Question::Text.create()
    when 'dropdown'
      question = Question::Dropdown.create()
      puts question
    when 'rating'
      question = Question::Rating.create()
      scale = Scale.create(low: "From", bins: 7, high: "To")
      question.scale = scale
    when 'checkbox'
      question = Question::Checkbox.create()
    when 'radio'
      question = Question::Radio.create()
    else
      redirect_to helpers.task_path(@task)
    end
    @task.questions << question
    redirect_to helpers.task_path(@task.acting_as)
  end
    
  private
    def question_task_params
      params.permit({task: [:name, :random]}, :taskable_id, :taskable_type)
    end
end
