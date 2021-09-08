class MakeTasksSortable < ActiveRecord::Migration[6.0]
  def change
    change_table :tasks do |t|
      t.integer :sort
    end
  end
end
