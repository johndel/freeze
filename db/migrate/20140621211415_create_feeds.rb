class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.integer :category_id
      t.text :title
      t.text :feed_type
      t.text :htmlurl
      t.text :xmlurl
      t.text :comment
      t.integer :position
      t.boolean :works, default: false

      t.timestamps
    end
    add_index :feeds, :category_id
  end
end
