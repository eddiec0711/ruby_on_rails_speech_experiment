class AddDefaultToExperimentComplete < ActiveRecord::Migration[6.0]
  def change
    change_column_default :experiments, :complete, false
  end
end
