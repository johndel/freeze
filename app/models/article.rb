class Article < ActiveRecord::Base
  # validates :title, :content, presence: true
  # validates :title, uniqueness: { scope: [ :feed_id, :article_updated ] }

  belongs_to :feed
  acts_as_taggable

end
