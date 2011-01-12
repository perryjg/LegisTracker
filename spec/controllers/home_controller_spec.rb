require 'spec_helper'

describe HomeController do
  render_views

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end

    it "should have correct title" do
      get 'index'
      response.should have_selector("title", :content => "AJC LegiTracker | Home" )
    end
    
    describe "Show recent bill data" do
      before( :each ) do
        @bill = Factory.create( :bill )
      end
      
      it "should have most recent bill event" do
        #@bill.statuses.create!( :statusDate => "2011-01-10", :statusCode => 'HPF' )
        Factory.create( :status, :bill => @bill )
        get 'index'
        response.should have_selector( "p", :class => 'event', :content => "2011-01-10" )
      end
    
      it "shold have most recent vote" do
        Factory.create( :vote, :bill => @bill )
        get 'index'
        response.should have_selector( "p", :class => 'vote', :content => "2011-01-10" )
      end
    end
    
    describe "Show RSS feeds" do
      it "should have house rss items" do
        get 'index'
        response.should have_selector( "a", :class => "rss house" )
      end
    
      it "should have senate rss items" do
        get 'index'
        response.should have_selector( "a", :class => "rss senate" )
      end
    end
  end
end
