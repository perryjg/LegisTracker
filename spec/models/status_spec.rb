require 'spec_helper'

describe Status do
  before(:each) do
    bill = Bill.create!( :number => "HB1" )
    bill.statuses.create!( :statusDate => '2011-01-10', :statusCode => 'HPF' )
  end
  it "should provide most recent" do
    status = Status.most_recent.first
    status.statusDate.to_s.should == '2011-01-10 00:00:00 UTC'
  end
end
