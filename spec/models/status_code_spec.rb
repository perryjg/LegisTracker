require 'spec_helper'

describe StatusCode do
  it { should have_many(:statuses) }
  
  it "should provide description of status" do
    @status = Factory.create( :status )
    @status.status_code.description.should == 'House Prefiled'
  end
end
