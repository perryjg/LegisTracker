require 'house_feed'
require 'senate_feed'

class HomeController < ApplicationController
  def index
    @title = 'Home'
    @events = Status.most_recent
    @votes = Vote.most_recent
    @house_rss = HouseFeed.new.items
    @senate_rss = SenateFeed.new.items
  end

end
