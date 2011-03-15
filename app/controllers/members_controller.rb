class MembersController < ApplicationController
  def index
    @title = 'Members'
    @reps = Member.reps.order( "seat" )
    @senators = Member.senators.order( "seat" )
  end

  def show
    @member = Member.find( params[:id] )
    @title = @member.name
    @bio = @member.pvs_bio
  end

end
