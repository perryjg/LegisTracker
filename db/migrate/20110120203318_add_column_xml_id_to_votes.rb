class AddColumnXmlIdToVotes < ActiveRecord::Migration
  def self.up
    add_column :votes, :xml_id, :integer
  end

  def self.down
    remove_column :votes, :xml_id
  end
end
