class ArticleFetcher
include Sidekiq::Worker
include Sidetiq::Schedulable

  recurrence { hourly.minute_of_hour(0, 15, 30, 45) }

  def perform
    Feed.all.each do |feed|
      feed.update_from_feed
    end
  end
end