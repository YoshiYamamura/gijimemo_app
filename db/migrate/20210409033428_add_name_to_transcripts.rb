class AddNameToTranscripts < ActiveRecord::Migration[6.0]
  def change
    add_column :transcripts, :name, :string, null: false
  end
end
