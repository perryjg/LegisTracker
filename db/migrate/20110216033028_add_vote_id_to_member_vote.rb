class AddVoteIdToMemberVote < ActiveRecord::Migration
  def self.up
    add_column :member_votes, :vote_id, :integer
  end

  def self.down
    remove_column :member_votes, :vote_id
  end
end
