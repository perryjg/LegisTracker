require 'spec_helper'

describe VotesController do
  before( :each ) do
    @user = Factory.create( :user )
    sign_in @user
  end

  describe VotesController, '#show' do
    before( :each ) do
      @bill = Factory.create( :bill )
      @vote = Factory.create( :vote, :bill => @bill )
      get :show, :id => @vote.id
    end
    it { should respond_with( :success ) }
    it { should assign_to( :vote ).with( @vote ) }
    it { should assign_to( :title ).with( "#{@vote.legislation}: #{@vote.description}" ) }
    it { should assign_to( :bill ).with( @vote.bill ) }
  end
  
  describe VotesController, '#key' do
    before( :each ) do
      @vote = Factory.create( :vote )
      get :key, :id => @vote.id
    end
    it { should respond_with( :redirect ) }
    it { should assign_to( :vote ).with( @vote ) }
    it { should set_the_flash.to( "Successfully tagged as key vote" ) }
  end

  describe VotesController, '#unkey' do
    before( :each ) do
      @vote = Factory( :vote )
      @vote.key_list.add( 'key' )
      @vote.save
      get :unkey, :id => @vote.id
    end
    it { should respond_with( :redirect ) }
    it { should assign_to( :vote ).with( @vote ) }
    it { should set_the_flash.to( "Successfully removed tag as key vote" ) }
  end
end
