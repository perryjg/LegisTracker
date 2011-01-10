class HomeController < ApplicationController
  def index
    @title = 'Home'
    @events = Status.most_recent
    @votes = Vote.most_recent
  end

end
