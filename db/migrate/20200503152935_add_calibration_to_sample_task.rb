class AddCalibrationToSampleTask < ActiveRecord::Migration[6.0]
  def change
    add_column :sample_tasks, :calibration, :boolean, default: false
  end
end
