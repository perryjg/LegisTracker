class HomeController < ApplicationController
  def index
    @title = 'Home'
    @bills = current_user ?
      current_user.watched_bills.order( "current_status_date DESC" ) :
      Bill.hot
      
    @votes = current_user ?
      current_user.watched_bill_votes :
      Vote.hot_bills.order_by_datetime_desc
    
    @house_rss = HouseFeed.find_recent
    @senate_rss = SenateFeed.find_recent
  end
end
