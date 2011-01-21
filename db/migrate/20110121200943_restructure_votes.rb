class RestructureVotes < ActiveRecord::Migration
  def self.up
    remove_column :votes, :house
    remove_column :votes, :bill_type
    remove_column :votes, :num
    remove_column :votes, :xml_id

    add_column :votes, :branch, :string
    add_column :votes, :xml_id, :string
    add_column :votes, :legislation, :string
  end

  def self.down
    remove_column :votes, :branch
    remove_column :votes, :legislation
    remove_column :votes, :xml_id

    add_column :votes, :house, :string, :limit => 1
    add_column :votes, :bill_type, :string, :limit => 2
    add_column :votes, :num, :integer
    add_column :votes, :xml_id, :integer
  end
end
