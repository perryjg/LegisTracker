require 'open-uri'
require 'simple-rss'
require 'simple_rss_patch'

module HouseFeed
  @rss = SimpleRSS.parse open( 'http://www.house-press.com/?feed=rss2' )
  
  def items
    @rss.items
  end
  
  def info
    @rss.channel
  end
end