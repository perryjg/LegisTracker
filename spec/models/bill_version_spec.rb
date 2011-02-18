require 'spec_helper'

describe BillVersion do
  before( :each ) do
    @version = Factory.create( :bill_version )
  end
  it { should belong_to( :bill ) }
  
  it "should return versoin url" do
    @version.url.should == "http://www1.legis.ga.gov/legis/2011_12/versions/#{@version.fileid}"
  end
  
  describe "ordered by number" do
    before( :each ) do
      @newer_version = Factory.create( :bill_version, :number => @version.number + 1 )
    end
    
    it "should order by number decsending" do
      top_search_result = BillVersion.order_desc.first
      top_search_result.number.should == @newer_version.number
    end
  
    it "should return latest version" do
      BillVersion.latest.should == @newer_version
    end
  end
end
