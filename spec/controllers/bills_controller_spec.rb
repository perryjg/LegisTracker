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
  end

  describe BillsController, '#search' do
    before( :each ) do
      get :search
    end
    it { should respond_with( :success ) }
    it { should render_template( :search ) }
    it { should assign_to( :title ).with( "Advanced Search" ) }
  end
  
  describe BillsController, '#hot' do
    before( :each ) do
      @bill = Factory.create( :bill )
      get :hot, :id => @bill.id
    end
    it { should respond_with(:redirect) }
    it { should set_the_flash.to( "Bill successfully tagged as hot" ) }
  end
  
  describe BillsController, '#unhot' do
    before( :each ) do
      @bill = Factory( :bill )
      @bill.hot_list.add( 'hot' )
      @bill.save
      get :unhot, :id => @bill.id
    end
    it { should respond_with( :redirect ) }
    it { should set_the_flash.to( "Bill successfully untagged as hot" ) }
  end
end
