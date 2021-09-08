class CreateSampleTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :sample_tasks do |t|
      t.string :audio_path
      t.string :transcript_path
    end
  end
end
