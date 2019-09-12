class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles, id: :uuid do |t|
      t.string :title
      t.text :body
      t.jsonb :analyze_results
      t.integer :source
      t.string :source_url
      t.datetime :publish_at
      t.boolean :publish
      t.references :user, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
