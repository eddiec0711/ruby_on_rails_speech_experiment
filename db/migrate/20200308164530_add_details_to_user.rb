class AddDetailsToUser < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.string :name
      t.string :institution
      t.string :country
      t.string :faculty
      t.string :research_level
      t.boolean :funded
      t.boolean :mailing_list
    end
  end
end
