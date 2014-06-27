class PagesController < ApplicationController

  def index
    unread_categories_id = Category.select(:id).joins(feeds: :articles).where(articles: {read_at: nil}).uniq.map(&:id)
    @categories = Category.includes(feeds: :articles).where(id: unread_categories_id)
    @unread_articles = Article.where(read_at: nil).count
  end

  def read_all
    @articles = Article.where(read_at: nil)
    @articles.update_all(read_at: Time.now)
    @categories = []
    flash[:notice] = "All articles mark as read."
  end

  def starred
    unread_categories_id = Category.select(:id).joins(feeds: :articles).where(articles: {starred: true}).uniq.map(&:id)
    categories = Category.includes(feeds: :articles).where(id: unread_categories_id)
    @articles = []

    categories.each do |category|
      category.feeds.each do |feed|
        feed.articles.select{ |a| a.starred == true }.each do |article|
          @articles << article
        end
      end
    end

  end

  def settings
  end

  private
    def all_categories

    end
end
