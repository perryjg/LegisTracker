class AddBillIdFieldToVotes < ActiveRecord::Migration
  def self.up
    add_column :votes, :bill_id, :integer
  end

  def self.down
    remove_column :votes, :bill_id
  end
end
