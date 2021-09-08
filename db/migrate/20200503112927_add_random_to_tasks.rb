class AddRandomToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :random, :boolean, default: false
  end
end
