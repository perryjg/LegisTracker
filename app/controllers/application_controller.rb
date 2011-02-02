class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load_bill_search_object
  
  private
  def load_bill_search_object
    @search = Bill.search( params[:search] )
  end
end
