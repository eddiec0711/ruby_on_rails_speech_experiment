module TasksHelper
  def task_path(task)
    case task.actable_type
    when "QuestionTask"
      question_task_path(:id => task.id)
    when "SampleTask"
      sample_task_path(:id => task.id)
    when "ListeningTask"
      listening_task_path(:id => task.id)
    when "ClickTask"
      click_task_path(:id => task.id)
    else
      raise "Unrecognised task type"
    end
  end

  def edit_task_path(task)
    case task.actable_type
    when "QuestionTask"
      edit_question_task_path(:id => task.id)
    when "SampleTask"
      edit_sample_task_path(:id => task.id)
    when "ListeningTask"
      edit_listening_task_path(:id => task.id)
    when "ClickTask"
      edit_click_task_path(:id => task.id)
    else
      raise "Unrecognised task type"
    end
  end

  def create_task_path(task)
    case task.actable_type
    when "QuestionTask"
      create_question_task_path(:id => task.id)
    when "SampleTask"
      create_sample_task_path(:id => task.id)
    when "ListeningTask"
      create_listening_task_path(:id => task.id)
    when "ClickTask"
      create_click_task_path(:id => task.id)
    else
      raise "Unrecognised task type"
    end
  end

  def taskable_path(taskable)
    if taskable.instance_of? Experiment
      experiment_path(taskable)
    else
      task_path(taskable.acting_as)
    end
  end
end
