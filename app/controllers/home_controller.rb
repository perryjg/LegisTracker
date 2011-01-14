require 'house_feed'
require 'senate_feed'
include HouseFeed
include SenateFeed

class HomeController < ApplicationController
  include HouseFeed
  include SenateFeed

  def index
    @title = 'Home'
    @events = Status.most_recent
    @votes = Vote.most_recent
    @house_rss = HouseFeed.items
    @senate_rss = SenateFeed.items
  end

end
