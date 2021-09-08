class Question < ApplicationRecord
  include RailsSortable::Model
  set_sortable :sort  # Indicate a sort column
  belongs_to :question_task
  has_many :responses, dependent: :destroy
  
  validates :prompt, presence: true
  validates :type, presence: true

  after_initialize :init

  def completion_errors
    if @experiment_errors.nil?
      @experiment_errors = {warnings: Array.new, errors: Array.new}
    end
    if prompt == default_name
      @experiment_errors[:warnings] << "#{type_name} in '#{question_task.name}' still has default prompt."
    end
    return @experiment_errors
  end

  def init
    self.prompt  ||= default_name
  end

  def default_name
    "New #{self.type_name.downcase}"
  end

  def type_name
    "Base question (you should not be seeing this)"
  end
end
