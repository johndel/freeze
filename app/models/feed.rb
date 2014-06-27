class Feed < ActiveRecord::Base
  validates :xmlurl, presence: true, uniqueness: true

  has_many :articles #, dependent: :destroy
  belongs_to :category
  before_create :set_basic_url
  before_save :check_feed

  def check_feed
    result = Feedjira::Feed.fetch_and_parse(xmlurl)
    self.works = result.is_a?(Integer) ? false : true
    # feed.article_count = result.entries.count rescue 0
  end

  def update_from_feed
    feed = Feedjira::Feed.fetch_and_parse(xmlurl)
    if feed.is_a? Integer
      self.save
    else
      add_entries(feed)
    end
  end

  def unread_articles?
    articles.select{ |article| article.read_at == nil }.present?
  end

  def unread_articles_count
    articles.select{ |article| article.read_at == nil }.count
  end

  private
    def add_entries(feed)
      feed.entries.each do |entry|
        guid = entry.id rescue ""
        if Article.where(guid: guid).empty?
          title = entry.title rescue "no title"
          content = entry.summary || entry.content rescue "no content"
          author = entry.author rescue ""
          url = entry.url rescue ""
          article_published = entry.published rescue ""
          article_updated = entry.updated rescue ""

          Article.create!(
            title: title,
            content: content,
            author: author,
            url: url,
            article_published: article_published,
            article_updated: article_updated,
            guid: guid,
            feed_id: self.id,
            source: self.htmlurl
          )
        end
      end
      self.article_count = self.articles.count
    end

    def set_basic_url
      if htmlurl
        url = URI.parse(htmlurl)
        self.base_url = "#{url.scheme}://#{url.host}"
      end
    end

end
