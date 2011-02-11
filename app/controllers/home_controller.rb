class HomeController < ApplicationController
  def index
    @title = 'Home'
    stdate = Status.last_date
    @status_date = params[:status_date] || Status.last_date.to_s
    @hot_events = Status.hot.most_recent
    @events = Status.find_for_date( @status_date )
    
    vdate = Vote.last_date
    @vote_date = params[:vote_date] || Vote.last_date.to_s
    @votes = Vote.find_for_date( @vote_date )
    
    @house_rss = HouseFeed.find_recent
    @senate_rss = SenateFeed.find_recent
  end
end
