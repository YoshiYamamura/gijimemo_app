class AddProgressPercentToTranscripts < ActiveRecord::Migration[6.0]
  def change
    add_column :transcripts, :progress_percent, :integer, default: 0, null: false
  end
end
