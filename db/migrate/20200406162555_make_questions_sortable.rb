class MakeQuestionsSortable < ActiveRecord::Migration[6.0]
  def change
    change_table :questions do |t|
      t.integer :sort
    end
  end
end
