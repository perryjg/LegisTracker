require 'spec_helper'

describe StatusesController do
  before( :each ) do
    @user = Factory.create( :user )
    sign_in @user
  end
  before( :each ) do
    @bill = Factory.create( :bill )
    @status = Factory.create( :status, :bill => @bill )
    @votes = Factory.create( :vote, :bill => @bill )
    get :index
  end

  describe StatusesController, "#index" do
    it { should respond_with( :success ) }
    it { should render_template( :index ) }
    it { should assign_to( :title ).with( 'Daily bill status report' ) }
    it { should assign_to( :status_date ).with( Status.last_date ) }
    it { should assign_to( :events ).with( Status.find_for_date( Status.last_date ) ) }
    it {should assign_to( :vote_date ).with( Vote.last_date.to_s ) }
    it { should assign_to( :votes ).with( Vote.find_for_date( Vote.last_date.to_s ) ) }
  end
end
