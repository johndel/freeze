class AddBaseUrlToFeed < ActiveRecord::Migration
  def change
    add_column :feeds, :base_url, :text
  end
end
