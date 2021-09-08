class Question::Checkbox < Question
  has_many :options, as: :chooseable, dependent: :destroy
  
  def type_name
    "Checkboxes"
  end

  def completion_errors
    @experiment_errors = {warnings: Array.new, errors: Array.new}
    if self.options.empty?
      @experiment_errors[:warnings] << "'#{prompt}' in '#{question_task.name}' has no checkbox options."
    end
    super
  end
end