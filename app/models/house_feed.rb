class HouseFeed < ActiveRecord::Base
  def self.update_from_feed( feed_url = 'http://www.house-press.com/?feed=rss2' )
    feed = Feedzirra::Feed.fetch_and_parse( feed_url )
    feed.sanitize_entries!
    feed.entries.each do |entry|
      unless exists? :guid => entry.id
        create!(
          :title        => entry.title,
          :summary      => entry.summary,
          :author       => entry.author,
          :url          => entry.url,
          :published_at => entry.published,
          :guid         => entry.id
        )
      end
    end
  end
  
  def self.find_recent( count = 5 )
    order( 'published_at DESC' ).limit( count )
  end
end
