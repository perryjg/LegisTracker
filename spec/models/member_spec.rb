require 'spec_helper'

describe Member do
  it { should have_many( :sponsorships ) }
  it { should have_many( :bills ).through( :sponsorships ) }
  
  describe "information formatted for display" do
    before( :each ) do
      @member = Factory.create( :member )
    end
    
    it "should return last_name, first_name as name" do
      @member.name.should == "#{@member.last_name}, #{@member.first_name}"
    end
    
    it "should return first_name last_name as display_name" do
      @member.display_name.should == "#{@member.first_name} #{@member.last_name}"
    end
    
    it "should return house and district as district_name" do
      @member.district_name.should == "#{@member.house}#{@member.district}"
    end
  end
  
  describe "party search scopes" do
    before( :each ) do
      Factory( :member, :party => 'D' )
      Factory( :member, :party => 'R' )
    end
    
    it "should return only democratic members" do
      Member.democrats.all.should == Member.where( "party = ?", 'D' )
    end
    
    it "should return only republican members" do
      Member.republicans.all.should == Member.where( "party = ?", 'R' )
    end
    
    it "should find members of a party" do
      Member.find_by_party('D').all.should == Member.where( "party = ?", 'D' )
      Member.find_by_party('R').all.should == Member.where( "party = ?", 'R' )
    end
  end
  
  describe "house search scopes" do
    before( :each ) do
      Factory( :member, :house => 'H' )
      Factory( :member, :house => 'S' )
    end
    
    it "should find only house members" do
      Member.reps.all.should == Member.where( "house = ?", 'H' )
    end
    
    it "should find only senate members" do
      Member.senators.all.should == Member.where( "house = ?", 'S' )
    end
    
    it "should find members of a house" do
      Member.find_by_house( 'H' ).all.should == Member.where( "house = ?", 'H' )
      Member.find_by_house( 'S' ).all.should == Member.where( "house = ?", 'S' )
    end
  end
end
