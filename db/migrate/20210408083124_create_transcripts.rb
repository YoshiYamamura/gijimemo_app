class CreateTranscripts < ActiveRecord::Migration[6.0]
  def change
    create_table :transcripts do |t|
      t.text       :transcript,     null: false
      t.integer    :status,         null: false
      t.references :user,           foreign_key: true
      t.timestamps
    end
  end
end
