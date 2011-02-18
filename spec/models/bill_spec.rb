require 'spec_helper'

describe Bill do
  before( :each ) do
    @attr = Factory.attributes_for( :bill )
  end
  
  it { should have_many( :statuses ) }
  it { should have_many( :votes ) }
  it { should have_many( :bill_versions ) }
  it { should have_many( :sponsorships ) }
  it { should have_many( :members ).through( :sponsorships ) }
  it { should belong_to( :house_committee ) }
  it { should belong_to( :senate_committee ) }

  it "should create new bill record" do
    previous_record_count = Bill.count
    bill = Bill.new( @attr )
    bill.save.should be true
    Bill.count.should == previous_record_count + 1
  end
  
  describe "taggable as hot bill" do
    before( :each ) do
      @bill = Factory.create( :bill )
    end
    
    it "should take tag 'hot'" do
      @bill.hot_list.add( 'hot' )
      @bill.save.should be true
    end
    
    it "should find bills tagged as hot" do
      hot_bill = Factory.create( :bill )
      hot_bill.hot_list = 'hot'
      hot_bill.save
      
      Bill.hot.all.should == Bill.tagged_with( 'hot' )
      Bill.hot.count.should == 1
      Bill.hot.first.should == hot_bill
    end
    
    it "should return true from is_hot? if hot" do
      @bill.hot_list = 'hot'
      @bill.is_hot?.should == true
    end
    
    it "should return false from is_hot? if not hot" do
      @bill.is_hot?.should == false
    end
  end
end
