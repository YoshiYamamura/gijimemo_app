class CreateTextDetections < ActiveRecord::Migration[6.0]
  def change
    create_table :text_detections do |t|
      t.string     :name,           null: false
      t.text       :text,           null: false
      t.integer    :status,         null: false
      t.references :user,           foreign_key: true
      t.timestamps
    end
  end
end
