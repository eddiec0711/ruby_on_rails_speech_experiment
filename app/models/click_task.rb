class ClickTask < ApplicationRecord
  acts_as :task # inherits from task model
  has_many :click_responses, dependent: :destroy
  def type_name
    "Reaction task"
  end

  def self.tooltip
    "Listen to the audio sample and click in reaction to a prompt, jutsifying your actions later"
  end

  def completion_errors
    @experiment_errors = {warnings: Array.new, errors: Array.new}
    # own errors
    if prompt.nil?
      @experiment_errors[:warnings] << "Reaction task '#{name}' for '#{taskable.name}' has no reaction prompt."
    end
    return @experiment_errors
  end
end
