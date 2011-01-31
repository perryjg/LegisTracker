require 'spec_helper'

describe Sponsorship do
  it { should belong_to( :bill ) }
  it { should belong_to( :member ) }
  
  describe "primary named scope" do
    before(:each) do
      Factory.create( :sponsorship, :seq => 1 )
      Factory.create( :sponsorship, :seq => 2 )
    end
    
    it "should find primary sponsorships" do
      Sponsorship.primary.should == Sponsorship.where( "seq = 1" )
    end
  end
  
  describe "secondary named scope" do
    before(:each) do
      Factory.create( :sponsorship, :seq => 1 )
      Factory.create( :sponsorship, :seq => 2 )
    end
    
    it "should find primary sponsorships" do
      Sponsorship.secondary.should == Sponsorship.where( "seq != 1" )
    end
  end
end
