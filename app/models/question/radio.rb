class Question::Radio < Question
  has_many :options, as: :chooseable, dependent: :destroy
  
  def type_name
    "Radio buttons"
  end

  def completion_errors
    @experiment_errors = {warnings: Array.new, errors: Array.new}
    if self.options.empty?
      @experiment_errors[:warnings] << "'#{prompt}' in '#{question_task.name}' has no radio button options."
    end
    super
  end
end