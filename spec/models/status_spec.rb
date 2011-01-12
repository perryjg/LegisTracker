require 'spec_helper'

describe Status do
  before(:each) do
    bill = Factory.create( :bill )
    Factory.create( :status, :bill => bill )
  end
  
  it "should provide most recent" do
    status = Status.most_recent.first
    status.statusDate.to_s.should match( /2011-01-10/ )
  end
end
