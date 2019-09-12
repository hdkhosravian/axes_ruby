class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.text :keyword_list
      t.references :user, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
