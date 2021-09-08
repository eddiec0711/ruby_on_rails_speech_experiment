class SampleTask < ApplicationRecord
  acts_as :task # inherits from task model
  has_many :tasks, class_name: 'Task', foreign_key: 'taskable_id', as: :taskable, dependent: :destroy
  has_one_attached :audio, dependent: :destroy
  has_one_attached :transcript, dependent: :destroy

  def complete
    taskable.complete
  end

  def type_name
    if calibration
      "Calibration audio sample"
    else
      "Audio sample"
    end
  end

  def allowed_tasks
    ['QuestionTask', 'ListeningTask', 'ClickTask']
  end

  def self.tooltip
    "An audio sample with additional questions or reaction tasks"
  end

  def completion_errors
    @experiment_errors = {warnings: Array.new, errors: Array.new}
    # task errors
    has_click_task = false
    self.tasks.each do |task|
      @experiment_errors[:warnings].concat task.specific.completion_errors[:warnings]
      @experiment_errors[:errors].concat task.specific.completion_errors[:errors]
      if task.actable_type == "ClickTask"
        has_click_task = true
      end
    end
    # own errors
    unless self.audio.attached?
      @experiment_errors[:errors] << "Audio sample '#{name}' has no audio file attached."
    end
    if has_click_task and not self.transcript.attached? and not calibration
      @experiment_errors[:errors] << "Audio sample '#{name}' has reaction tasks but has no transcript file attached."
    end
    if calibration and not has_click_task
      @experiment_errors[:warnings] << "Audio sample '#{name}' is marked as a calibration sample but has no click tasks."
    end
    return @experiment_errors
  end
end
