class HomeController < ApplicationController
  def index
    @title = 'Home'
    stdate = Status.last_date
    @status_date = params[:status_date] || Status.last_date.to_s
    @events = Status.find_for_date( @status_date )
    
    @votes = Vote.most_recent
    
    @house_rss = HouseFeed.find_recent
    @senate_rss = SenateFeed.find_recent
  end
end
