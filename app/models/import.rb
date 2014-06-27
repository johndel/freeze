class Import < ActiveRecord::Base

  def self.import_rss(rss_file = nil)
    counter = 0
    rss_file_path = File.open(Rails.root + 'lib/imports/ttrss.opml') if rss_file.nil?
    rss_file = Nokogiri::XML(rss_file_path)
    import = Import.create(raw_data: rss_file_path.read)
    rss_file.search("body").first.css("outline").each do |rss|
      title = rss.attributes["text"].value rescue ""
      feed_type = rss.attributes["type"].value rescue ""
      xmlUrl = rss.attributes["xmlUrl"].value rescue ""
      htmlUrl = rss.attributes["htmlUrl"].value rescue ""
      if xmlUrl.present?
        unless Feed.where(xmlurl: xmlUrl).exists?
          counter = counter + 1
          puts "#{counter} - #{xmlUrl}"
          feed = Feed.create!(title: title,
                              feed_type: feed_type,
                              xmlurl: xmlUrl,
                              htmlurl: htmlUrl,
                              category: @category)
        end
      else
        if title.present? && Category.where(name: title).blank?
          counter = counter + 1
          puts "#{counter} - #{title}"
          @category = Category.create!(name: title)
        end
      end
    end
  end

end
