namespace :import_feeds do
  desc "USAGE: rake import_feed"

  task opml: :environment do
    Import.import_rss
    # binding.pry
    # import = Import.create()
    # Rails.root + 'lib/imports/subscriptions.xml'
  end
end