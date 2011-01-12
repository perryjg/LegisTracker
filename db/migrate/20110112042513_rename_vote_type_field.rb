class RenameVoteTypeField < ActiveRecord::Migration
  def self.up
    rename_column :votes, :type, :bill_type
  end

  def self.down
    rename_column :votes, :bill_type, :type
  end
end
