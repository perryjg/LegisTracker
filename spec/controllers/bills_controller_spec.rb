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

end
