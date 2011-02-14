require 'spec_helper'

describe MembersController do

  describe MembersController, '#index' do
    before( :each ) do
      get :index
    end
    it { should respond_with( :success ) }
    it { should assign_to( :title ).with( "Members" ) }
  end

  describe MembersController, '#show' do
    before( :each ) do
      @member = Factory.create( :member )
      get :show, :id => @member.id
    end
    it { should respond_with( :success ) }
    it { should assign_to( :title ).with( @member.name ) }
    it { should assign_to( :member ).with( @member ) }
  end
end
