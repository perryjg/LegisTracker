require 'spec_helper'

describe MembersController do
  before( :each ) do
    @user = Factory.create( :user )
    sign_in @user
  end

  describe MembersController, '#index' do
    before( :each ) do
      get :index
    end
    it { should respond_with( :success ) }
    it { should assign_to( :title ).with( "Members" ) }
    it "should route members_path to members/index" do
      { :get => members_path }.should route_to( :controller => "members", :action => "index" )
    end
  end

  describe MembersController, '#show' do
    before( :each ) do
      @member = Factory.create( :member )
      get :show, :id => @member.id
    end
    it { should respond_with( :success ) }
    it { should assign_to( :title ).with( @member.name ) }
    it { should assign_to( :member ).with( @member ) }
    it "should route member_path to members/show" do
      { :get => member_path }.should route_to( :controller => "members", :action => "show", :id => @member.to_param )
    end
  end
end
