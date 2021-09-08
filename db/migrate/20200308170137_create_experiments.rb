class CreateExperiments < ActiveRecord::Migration[6.0]
  def change
    create_table :experiments do |t|
      t.integer :owner
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
