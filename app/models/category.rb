class Category < ActiveRecord::Base
  # acts_as_nested_set
  validates :name, presence: true, uniqueness: true
  has_many :feeds, dependent: :destroy

  before_create :set_position

  def unread_articles?
    return_value = false
    feeds.each do |feed|
      if feed.unread_articles?
        return_value = true
        break
      end
    end
    return_value
  end


  def unread_articles_count
    counter = 0
    feeds.each do |feed|
      if feed.unread_articles?
        counter += feed.unread_articles_count
      end
    end
    counter
  end

  private
    def set_position
      tmp_position = Category.maximum(:position) || 0
      self.position = tmp_position + 1
    end
end
