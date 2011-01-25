class BillsController < ApplicationController
  def index
    @bills = Bill.all
  end

  def show
  end

  def search
    @bills = Bill.search(params[:search])
    render :index
  end
end
