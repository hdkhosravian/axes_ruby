class CreateKeywords < ActiveRecord::Migration[5.2]
  def change
    create_table :keywords, id: :uuid do |t|
      t.string :key

      t.timestamps
    end
  end
end
