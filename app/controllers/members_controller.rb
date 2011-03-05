class MembersController < ApplicationController
  def index
    @title = 'Members'
    @reps = Member.reps.all
    @senators = Member.senators.all
  end

  def show
    @member = Member.find( params[:id] )
    @title = @member.name
  end

end
