require 'spec_helper'

describe HomeController do
  describe HomeController, '#index' do
    before( :each ) do
      @bill = Factory.create( :bill )
      @bill.hot_list.add( 'hot' )
      @bill.save
      
      @status = Factory.create( :status, :bill => @bill )
      @votes = Factory.create( :vote, :bill => @bill )
      @house_feed = Factory.create( :house_feed )
      @senate_feed = Factory.create( :senate_feed )
      get :index
    end
    it { should respond_with( :success ) }
    it { should render_template :index }
    it { should assign_to( :title ).with( 'Home' ) }
    
    it "should route '/' to home/index" do
      { :get => "/" }.should route_to( :controller => "home", :action => "index" )
    end
    
    it "should route root_path to home/index" do
      { :get => root_path }.should route_to( :controller => "home", :action => "index" )
    end

    describe "Show watched bill events" do
      it { should assign_to( :events ).with( Status.hot.by_date_desc ) }
      it { should assign_to( :votes ).with( Vote.hot_bills.order_by_datetime_desc ) }
    end
    
    describe "Show recent press releases" do
      it { should assign_to( :house_rss  ).with( HouseFeed.find_recent  ) }
      it { should assign_to( :senate_rss ).with( SenateFeed.find_recent ) }
    end
  end
end
