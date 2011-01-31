class MembersController < ApplicationController
  def index
    @title = 'Members'
  end

  def show
    @member = Member.find( params[:id] )
    @title = @member.name
  end

end
