class VotesController < ApplicationController
  def show
    @vote = Vote.find( params[:id] )
    @title = "#{@vote.legislation}: #{@vote.description}"
    @bill = @vote.bill
    @repub_votes = @vote.member_votes.republican.order_by_district
    @demo_votes = @vote.member_votes.democrat.order_by_district
  end
  
  def key
    @vote = Vote.find( params[:id] )
    @vote.key_list.add( 'key' )
    if @vote.save
      flash[:notice] = "Successfully tagged as key vote"
    else
      flash[:error] = "Tagging failed"
    end
    redirect_to( @vote )
  end
  
  def unkey
    @vote = Vote.find( params[:id] )
    @vote.key_list.remove( 'key' )
    if @vote.save
      flash[:notice] = "Successfully removed tag as key vote"
    else
      flash[:error] = "Untagging failed"
    end
    redirect_to( @vote )
  end
end
