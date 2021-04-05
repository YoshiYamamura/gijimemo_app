class CreateAccessPermits < ActiveRecord::Migration[6.0]
  def change
    create_table :access_permits do |t|
      t.references :meeting,        foreign_key: true
      t.references :user,           foreign_key: true
      t.timestamps
    end
  end
end
