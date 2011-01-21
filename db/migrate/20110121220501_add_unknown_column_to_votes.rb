class AddUnknownColumnToVotes < ActiveRecord::Migration
  def self.up
    add_column :votes, :unknown, :integer
  end

  def self.down
    remove_column :votes, :unknown
  end
end
