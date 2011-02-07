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
  
  describe "methods provided by Member model" do
    before( :each ) do |variable|
      @member = Factory( :member )
      @sponsorship = Factory( :sponsorship, :member => @member )
    end
    
    it "should provide name" do
      @sponsorship.name.should == @member.name
    end
    
    it "should provide display_name" do
      @sponsorship.display_name.should == @member.display_name
    end

    it "should provide first_name" do
      @sponsorship.first_name.should == @member.first_name
    end

    it "should provide last_name" do
      @sponsorship.last_name.should == @member.last_name
    end

    it "should provide district_name" do
      @sponsorship.district_name.should == @member.district_name
    end
  end
end
