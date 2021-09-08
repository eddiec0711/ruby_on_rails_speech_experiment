class CreateListeningTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :listening_tasks do |t|
      t.integer :listens

      t.timestamps
    end
  end
end
