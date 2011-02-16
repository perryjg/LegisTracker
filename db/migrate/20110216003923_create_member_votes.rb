class CreateMemberVotes < ActiveRecord::Migration
  def self.up
    create_table :member_votes do |t|
      t.integer :member_id
      t.integer :bill_id
      t.string :vote, :limit => 1
    end
  end

  def self.down
    drop_table :member_votes
  end
end
