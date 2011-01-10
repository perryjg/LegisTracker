require 'spec_helper'

describe Vote do
  before(:each) do
    bill = Bill.create!( :number => "HB1" )
    bill.votes.create!( :house => 'H',
                        :date => '2011-01-10',
                        :type => 'HB',
                        :num => 1,
                        :description => 'PASS',
                        :yea => 100,
                        :nay => 80 )
  end
  
  it "should provide most recent" do
    vote = Vote.most_recent.first
    vote.date.to_s.should == '2011-01-10 00:00:00 UTC'
  end
end
