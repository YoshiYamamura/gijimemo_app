class AddAudioDurationToTranscripts < ActiveRecord::Migration[6.0]
  def change
    add_column :transcripts, :audio_duration, :time, null: false
  end
end
