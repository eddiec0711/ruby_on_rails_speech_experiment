module ResponsesHelper

  def task_view_partial(task)
    customize_partial_path(task, ->(model){"responses/tasks/#{model.class.model_name.singular}/view"})
  end

  def new_responses_partial(question)
    customize_partial_path(question, ->(model){"responses/questions/#{model.class.model_name.singular.gsub('question_', '')}/new"})
  end

  def next_task(taskable, participant_id)
    visited_count = taskable.tasks.includes(:visits).where(visits: {participant_id: participant_id, visited: true}).count
    next_task = taskable.tasks.order(:sort).offset(visited_count).first
    if next_task.nil? # end of main/sub tasks
      case taskable
      when Experiment # end of main tasks
        finish_experiment_path
      when SampleTask # end of sub tasks
        taskable.visit(participant_id)
        next_task(taskable.taskable, participant_id)
      end 
    else
      next_task = random?(taskable, next_task, participant_id)
      task_page(next_task, participant_id)
    end 
  end

  def random?(taskable, task, participant_id)
    if task.random
      return taskable.tasks.includes(:visits).where(random: true, visits: {participant_id: participant_id, visited: false}).sample
    else 
      return task
    end 
  end

  def task_page(task, participant_id)
    case task.actable_type
    when 'SampleTask'
      show_response_path(sample_id: task.actable_id, participant_id: participant_id)
    when 'QuestionTask', 'ClickTask', 'ListeningTask'
      new_response_path(actable_type: task.actable_type, actable_id: task.actable_id, participant_id: participant_id)
    end 
  end 

end