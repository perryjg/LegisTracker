require 'spec_helper'

describe Vote do
  before(:each) do
    @bill = Factory.create( :bill )
    Factory.create( :vote, :bill => @bill )
  end
  
  it "should provide most recent" do
    last_date = Vote.last_date
    vote = Vote.most_recent.first
    vote.date.to_s.should match( /2011-01-10/ )
  end
end
