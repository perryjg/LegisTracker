require 'spec_helper'

describe MembersController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      member = Factory.create( :member )
      get 'show', :id => member.id
      response.should be_success
    end
  end
end
