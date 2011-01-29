require 'spec_helper'

describe HomeController do
  render_views

  describe "GET 'index'" do
    before( :each ) do
      @bill = Factory.create( :bill )
      @status = Factory.create( :status, :bill => @bill )
      @votes = Factory.create( :vote, :bill => @bill )
    end
    
    it "should be successful" do
      get 'index'
      response.should be_success
    end

    it "should have correct title" do
      get 'index'
      response.should have_selector("title", :content => "AJC LegiTracker | Home" )
    end
    
    describe "Show recent bill data" do
      it "should have most recent bill event" do
        get 'index'
        response.should have_selector( "*", :class => 'event' )
      end
    
      it "shold have most recent vote" do
        Factory.create( :vote, :bill => @bill )
        get 'index'
        response.should have_selector( "*", :class => 'vote' )
      end
    end
    
    describe "Show RSS feeds" do
      it "should have house rss items" do
        Factory.create( :house_feed )
        get 'index'
        response.should have_selector( "*", :class => "rss house" )
      end
    
      it "should have senate rss items" do
        Factory.create( :senate_feed )
        get 'index'
        response.should have_selector( "*", :class => "rss senate" )
      end
    end
  end
end
