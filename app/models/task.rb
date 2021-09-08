class Task < ApplicationRecord
  include RailsSortable::Model
  actable # helper from acts_as - acts as a superclass for other tasks (question, sample, click)
  belongs_to :taskable, polymorphic: true # can be owned by objects of different classes (experiment, sample task)
  set_sortable :sort  # Indicate a sort column
  has_many :visits, dependent: :destroy

  validates :name, presence: true

  def visit(participant_id)
    visit = self.visits.find_by(participant_id: participant_id)
    visit.visited = true
    visit.save
  end 

  def completion_errors
    if @experiment_errors.nil?
      @experiment_errors = {warnings: Array.new, errors: Array.new}
    end
    return @experiment_errors
  end
end
