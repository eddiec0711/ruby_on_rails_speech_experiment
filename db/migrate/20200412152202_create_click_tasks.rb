class CreateClickTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :click_tasks do |t|
      t.text :prompt

      t.timestamps
    end
  end
end
