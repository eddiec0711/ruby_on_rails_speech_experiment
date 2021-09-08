class AddDefaultToListeningTask < ActiveRecord::Migration[6.0]
  def change
    change_column_default :listening_tasks, :listens, 1
  end
end
