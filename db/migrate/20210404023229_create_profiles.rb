class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string     :family_name
      t.string     :first_name
      t.string     :belonging
      t.text       :self_introduction
      t.references :user,           foreign_key: true
      t.timestamps
    end
  end
end
