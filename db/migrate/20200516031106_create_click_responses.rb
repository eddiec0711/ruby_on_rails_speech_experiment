class CreateClickResponses < ActiveRecord::Migration[6.0]
  def change
    create_table :click_responses do |t|
      t.integer :participant_id
      t.float :time
      t.string :answer
      t.references :click_task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
