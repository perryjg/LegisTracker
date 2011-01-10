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
    
    it "should have most recent bill event" do
      b = Bill.create!( :number => "HB1" )
      b.statuses.create!( :statusDate => "2011-01-10", :statusCode => 'HPF' )
      get 'index'
<<<<<<< HEAD
      response.should have_selector( "p", :class => 'event', :content => "2011-01-10" )
=======
      response.should have_selector( "p", :content => "HB1" )
>>>>>>> c09e07584dd1af5a30c11b42eb356e1366535379
    end
    
    it "shold have most recent vote" do
      b = Bill.create!( :number => "HB1" )
      b.votes.create!( :house => 'H',
                       :date => '2011-01-10',
                       :type => 'HB',
                       :num => 1,
                       :description => 'PASS',
                       :yea => 100,
                       :nay => 80 )
      get 'index'
<<<<<<< HEAD
      response.should have_selector( "p", :class => 'vote', :content => "2011-01-10" )
=======
      response.should have_selector( "p", :content => "2011-01-10 00:00:00 UTC PASS" )
>>>>>>> c09e07584dd1af5a30c11b42eb356e1366535379
    end
  end
end
