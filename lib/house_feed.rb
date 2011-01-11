require 'open-uri'
require 'simple-rss'
require 'simple_rss_patch'

class HouseFeed
  def initialize
    @rss = SimpleRSS.parse open( 'http://www.house-press.com/?feed=rss2' )
  end
  
  def items
    @rss.items
  end
  
  def info
    @rss.channel
  end
end