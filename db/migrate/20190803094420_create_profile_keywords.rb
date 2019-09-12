class CreateProfileKeywords < ActiveRecord::Migration[5.2]
  def change
    create_table :profile_keywords, id: :uuid do |t|
      t.references :keyword, type: :uuid, foreign_key: true
      t.references :profile, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
