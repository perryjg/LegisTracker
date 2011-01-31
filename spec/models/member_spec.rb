require 'spec_helper'

describe Member do
  it { should have_many( :sponsorships ) }
  it { should have_many( :bills ).through( :sponsorships ) }
  
  it "should provide formatted full name" do
    member = Factory.create( :member )
    member.name.should == "#{member.last_name}, #{member.first_name}"
  end
end
