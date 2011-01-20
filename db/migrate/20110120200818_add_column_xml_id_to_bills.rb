class AddColumnXmlIdToBills < ActiveRecord::Migration
  def self.up
    add_column :bills, :xml_id, :integer
  end

  def self.down
    remove_column :bills, :xml_id
  end
end
