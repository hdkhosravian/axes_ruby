class AddLastAnalyzeToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :last_analyze, :datetime
  end
end
