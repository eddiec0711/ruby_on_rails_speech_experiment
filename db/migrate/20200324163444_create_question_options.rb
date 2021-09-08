class CreateQuestionOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :question_options do |t|
      t.string :contents
      t.references :chooseable, polymorphic: true

      t.timestamps
    end
  end
end
