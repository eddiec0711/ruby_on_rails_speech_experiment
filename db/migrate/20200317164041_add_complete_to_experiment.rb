class AddCompleteToExperiment < ActiveRecord::Migration[6.0]
  def change
    change_table :experiments do |t|
      t.boolean :complete
    end
  end
end
