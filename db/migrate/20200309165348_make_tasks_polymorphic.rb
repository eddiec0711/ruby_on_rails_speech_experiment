class MakeTasksPolymorphic < ActiveRecord::Migration[6.0]
  def change
    change_table :tasks do |t|
      t.remove :experiment_id

      t.references :taskable, polymorphic: true
    end
  end
end
