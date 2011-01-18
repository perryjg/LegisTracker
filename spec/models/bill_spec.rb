require 'spec_helper'

describe Bill do
  before( :each ) do
    @attr = Factory.attributes_for( :bill )
  end
  
  it { should have_many(:statuses) }
  it { should have_many(:votes) }

  it "should create new bill record" do
    previous_record_count = Bill.count
    bill = Bill.new( @attr )
    bill.save.should be true
    Bill.count.should == previous_record_count + 1
  end
end
