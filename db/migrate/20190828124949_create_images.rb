class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images, id: :uuid do |t|
      t.references :imageable, polymorphic: true
      t.attachment :picture

      t.timestamps
    end
  end
end
