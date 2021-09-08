class AddTaskRefToVisits < ActiveRecord::Migration[6.0]
  def change
    add_reference :visits, :task, foreign_key: true
  end
end
