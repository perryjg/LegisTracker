require 'open-uri'
require 'simple-rss'
require 'simple_rss_patch'

class SenateFeed
  def initialize
    @rss = SimpleRSS.parse open( 'http://senatepress.net/feed' )
  end
  def items
    @rss.items
  end
  def info
    @rss.channel
  end
end