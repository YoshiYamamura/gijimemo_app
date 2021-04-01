class CreateMeetings < ActiveRecord::Migration[6.0]
  def change
    create_table :meetings do |t|
      t.string     :name,           null: false
      t.date       :meeting_date
      t.time       :meeting_time
      t.string     :place
      t.text       :attendance
      t.text       :speech
      t.references :user,           foreign_key: true
      t.timestamps
    end
  end
end
