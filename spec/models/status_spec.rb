require 'spec_helper'

describe Status do
  before(:each) do
    @bill = Factory.create( :bill )
    Factory.create( :status, :bill => @bill )
  end
  
  it "should create new status record" do
    previous_record_count = Status.count
    status = @bill.statuses.new( Factory.attributes_for( :status ) )
    status.save.should be true
    Status.count.should == previous_record_count + 1
  end

  it "should have correct bill id" do
    status = @bill.statuses.new( Factory.attributes_for( :status ) )
    status.save.should be true
    status.bill_id.should == @bill.id
  end

  it "should provide most recent status events" do
    status = Status.most_recent.first
    status.status_date.to_s.should match( /2011-01-10/ )
  end
  
  describe "last_date method" do
    before( :each ) do
      Factory.create( :status, :bill => @bill, :status_date => '2011-01-05 12:00:00' )
    end

    it "should match find max date result" do
      Status.maximum( "DATE(status_date)" ).should == Status.last_date
    end
    
    it "should not match older dates" do
      Status.last_date.should_not be < '2011-01-10'
    end
  end
  
  describe "most_recent method" do
    before( :each ) do
      Factory.create( :status, :bill => @bill, :status_date => '2011-01-05 12:00:00' )
    end

    it "should include all statuses on most recent date" do
      Factory.create( :status, :bill=> @bill, :status_date => '2011-01-10 15:00:00')
      Status.where( "DATE(status_date) = ?", Status.last_date ).should == Status.most_recent
    end
    
    it "should not include statuses from older dates" do
      Status.most_recent.each do |recent|
        Status.where( "DATE(status_date) != ?", Status.last_date ).each do |old|
          recent.should_not == old
        end
      end
    end
  end
end
