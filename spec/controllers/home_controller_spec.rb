require 'spec_helper'

describe HomeController do
  describe HomeController, '#index' do
    before( :each ) do
      @bill = Factory.create( :bill )
      @status = Factory.create( :status, :bill => @bill )
      @votes = Factory.create( :vote, :bill => @bill )
      @house_feed = Factory.create( :house_feed )
      @senate_feed = Factory.create( :senate_feed )
      get :index
    end
    it { should respond_with( :success ) }
    it { should render_template :index }
    it { should assign_to( :title ).with( 'Home' ) }

    describe "Show recent bill events" do
      it { should assign_to( :status_date ).with( Status.last_date.to_s ) }
      it { should assign_to( :events ).with( Status.find_for_date( Status.last_date.to_s ) ) }
      it { should assign_to( :vote_date ).with( Vote.last_date.to_s ) }
      it { should assign_to( :votes ).with( Vote.find_for_date( Vote.last_date.to_s ) ) }
      
      it "should assign @hot_events" do
        @hot_event = Factory( :bill )
        @hot_event.hot_list.add( 'hot' )
        @hot_event.save
        
        assigns[:hot_events].should == Status.hot.most_recent
      end
    end
    
    describe "Show recent press releases" do
      it { should assign_to( :house_rss  ).with( HouseFeed.find_recent  ) }
      it { should assign_to( :senate_rss ).with( SenateFeed.find_recent ) }
    end
  end
end
