class CreateWatchedBills < ActiveRecord::Migration
  def self.up
    create_table :watched_bills do |t|
      t.integer :user_id
      t.integer :bill_id

      t.timestamps
    end
  end

  def self.down
    drop_table :watched_bills
  end
end
