class AddAnalyzeCategoryToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :analyze_category, :bigint
  end
end
