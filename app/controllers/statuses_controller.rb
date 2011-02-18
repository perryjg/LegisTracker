class StatusesController < ApplicationController
  def index
    @title = 'Daily bill status report'
    stdate = Status.last_date
    @status_date = params[:status_date] || Status.last_date.to_s
    @events = Status.find_for_date( @status_date )
    
    vdate = Vote.last_date
    @vote_date = params[:vote_date] || Vote.last_date.to_s
    @votes = Vote.find_for_date( @vote_date )
  end

end
