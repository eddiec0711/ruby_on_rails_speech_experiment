class AddQuestionRefToResponse < ActiveRecord::Migration[6.0]
  def change
    add_reference :responses, :question, foreign_key: true
  end
end
