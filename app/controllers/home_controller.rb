class HomeController < ApplicationController
  def index
    @title = 'Home'
    @events = Status.most_recent
    @votes = Vote.most_recent
    @house_rss = HouseFeed.find_recent
    @senate_rss = SenateFeed.find_recent
  end
end
