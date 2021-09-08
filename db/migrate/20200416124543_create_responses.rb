class CreateResponses < ActiveRecord::Migration[6.0]
  def change
    create_table :responses do |t|
      t.string :answer
      t.integer :participant_id

      t.timestamps
    end
  end
end
