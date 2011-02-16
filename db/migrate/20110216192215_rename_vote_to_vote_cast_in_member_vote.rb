class RenameVoteToVoteCastInMemberVote < ActiveRecord::Migration
  def self.up
    rename_column :member_votes, :vote, :vote_cast
  end

  def self.down
    rename_column :member_votes, :vote_cast, :vote
  end
end
