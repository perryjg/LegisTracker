require 'spec_helper'

describe BillsController do
  describe BillsController, '#index' do
    before( :each ) do
      get :index
    end
    it { should respond_with( :success ) }
    it { should render_template( :index ) }
    it { should assign_to( :title ).with( "Search results" ) }
    it { should assign_to( :bills ) }
    it "should route '/bills' to bills/index" do
      { :get => bills_path }.should route_to( :controller => "bills", :action => "index" )
    end
  end

  describe BillsController, '#show' do
    before( :each ) do
      @bill = Factory.create( :bill )
      get :show, :id => @bill.id
    end
    it { should respond_with( :success ) }
    it { should render_template( :show ) }
    it { should assign_to( :bill ).with( @bill ) }
    it { should assign_to( :title ).with( @bill.number ) }
    it "should route bill_path to bills/should" do
      { :get => bill_path }.should route_to( :controller => "bills", :action => "show", :id => @bill.to_param )
    end
  end

  describe BillsController, '#search' do
    before( :each ) do
      get :search
    end
    it { should respond_with( :success ) }
    it { should render_template( :search ) }
    it { should assign_to( :title ).with( "Advanced Search" ) }
    it "should route search_path to bills/search" do
      { :get => search_path }.should route_to( :controller => "bills", :action => "search" )
    end
  end
  
  describe BillsController, '#hot' do
    before( :each ) do
      @bill = Factory.create( :bill )
      get :hot, :id => @bill.id
    end
    it { should respond_with(:redirect) }
    it { should set_the_flash.to( "Bill successfully added to the watch list" ) }
    it "should route hot_bill_path to bills/hot" do
      { :get => hot_bill_path }.should route_to( :controller => "bills", :action => "hot", :id => @bill.to_param )
    end
  end
  
  describe BillsController, '#unhot' do
    before( :each ) do
      @bill = Factory( :bill )
      @bill.hot_list.add( 'hot' )
      @bill.save
      get :unhot, :id => @bill.id
    end
    it { should respond_with( :redirect ) }
    it { should set_the_flash.to( "Bill successfully removed to watch list" ) }
    it "should route unhot_bill_path to bills/unhot" do
      { :get => unhot_bill_path }.should route_to( :controller => "bills", :action => "unhot", :id => @bill.to_param )
    end
  end
end
