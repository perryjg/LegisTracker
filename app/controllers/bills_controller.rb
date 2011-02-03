class BillsController < ApplicationController
  def index
    @title = 'Search results'
    @bills = @search.all
  end

  def show
    @bill = Bill.find(params[:id])
    @title = @bill.number
  end

  def search
    @title = "Advanced Search"
  end
end
