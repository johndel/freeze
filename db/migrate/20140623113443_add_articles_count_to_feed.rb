class AddArticlesCountToFeed < ActiveRecord::Migration
  def change
    add_column :feeds, :article_count, :integer
  end
end
