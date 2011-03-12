class HomeController < ApplicationController
  def index
    @title = 'Home'
    @events = current_user ?
      current_user.watched_bill_statuses :
      Status.hot.by_date_desc
      
    @votes = current_user ?
      current_user.watched_bill_votes :
      Vote.hot_bills.order_by_datetime_desc
    
    @house_rss = HouseFeed.find_recent
    @senate_rss = SenateFeed.find_recent
  end
end
