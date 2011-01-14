require 'open-uri'
require 'simple-rss'
require 'simple_rss_patch'

module SenateFeed
  @rss = SimpleRSS.parse open( 'http://senatepress.net/feed' )

  def items
    @rss.items
  end
  def info
    @rss.channel
  end
end