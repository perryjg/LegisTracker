require 'spec_helper'

describe HomeController do
  render_views

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end

    it "should have correct title" do
      get 'index'
      response.should have_selector("title", :content => "AJC LegiTracker | Home" )
    end
  end

end
