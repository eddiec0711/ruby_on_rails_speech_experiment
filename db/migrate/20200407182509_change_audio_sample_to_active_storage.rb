class ChangeAudioSampleToActiveStorage < ActiveRecord::Migration[6.0]
  def change
    change_table :sample_tasks do |t|
      t.remove :audio_path
      t.remove :transcript_path
    end
  end
end
