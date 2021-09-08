class CorrectExperimentForeignKey < ActiveRecord::Migration[6.0]
  def change
    change_table :experiments do |t|
      t.remove :owner
      t.belongs_to :user
    end
  end
end
