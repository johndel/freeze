class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.boolean :starred, default: false
      t.text  :guid
      t.integer :feed_id
      t.boolean :clicked, default: false
      t.boolean :seen, default: false
      t.text :title
      t.text :content
      t.text :author
      t.text :url
      t.text :source
      t.datetime :article_published
      t.datetime :article_updated
      t.datetime :read_at

      t.timestamps
    end
    add_index :articles, :feed_id
  end
end
