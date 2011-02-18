class HomeController < ApplicationController
  def index
    @title = 'Home'
    @events = Status.hot.by_date_desc
    @votes = Vote.hot_bills.order_by_datetime_desc
    
    @house_rss = HouseFeed.find_recent
    @senate_rss = SenateFeed.find_recent
  end
end
