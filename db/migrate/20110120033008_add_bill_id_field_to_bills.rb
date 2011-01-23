class AddBillIdFieldToBills < ActiveRecord::Migration
  def self.up
    add_column :bills, :bill_id, :integer
  end

  def self.down
    remove_column :bills, :bill_id
  end
end
