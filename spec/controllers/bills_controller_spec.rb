require 'spec_helper'

describe BillsController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      @bill = Factory.create( :bill )
      get 'show', :id => @bill.id
      response.should be_success
    end
  end

  describe "GET 'search'" do
    it "should be successful" do
      get 'search'
      response.should be_success
    end

    it "should have the correct title" do
      get 'search'
      response.should have_selector( "title", :content => "Advanced Search" )
    end
  end
end
