class CreateScales < ActiveRecord::Migration[6.0]
  def change
    create_table :scales do |t|
      t.integer :bins
      t.string :high
      t.string :low
      t.belongs_to :rating

      t.timestamps
    end
  end
end
