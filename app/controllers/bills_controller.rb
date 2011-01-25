class BillsController < ApplicationController
  def index
    @title = 'Search results'
    @bills = Bill.all
  end

  def show
    @bill = Bill.find(params[:id])
    @title = @bill.number
  end

  def search
    @bills = Bill.search(params[:search])
    render :index
  end
end
