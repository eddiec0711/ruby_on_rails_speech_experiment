class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.text :prompt
      t.string :type
      t.belongs_to :question_task

      t.timestamps
    end
  end
end
