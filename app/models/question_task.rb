class QuestionTask < ApplicationRecord
  acts_as :task # inherits from task model
  has_many :questions, dependent: :destroy
  has_many :responses, through: :questions

  def type_name
    "Question page"
  end

  def self.tooltip
    "Add a page of questions"
  end

  def completion_errors
    @experiment_errors = {warnings: Array.new, errors: Array.new}
    # question errors
    self.questions.each do |question|
      @experiment_errors[:warnings].concat question.completion_errors[:warnings]
      @experiment_errors[:errors].concat question.completion_errors[:errors]
    end
    # own errors
    if self.questions.empty?
      @experiment_errors[:errors] << "Question page '#{name}' does not contain any questions."
    end
    return @experiment_errors
  end
end
