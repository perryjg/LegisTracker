class CreateHouseCommittees < ActiveRecord::Migration
  def self.up
    create_table :house_committees do |t|
      t.string :committee_name
      t.string :committee_short_name, :limit => 10

      t.timestamps
    end
  end

  def self.down
    drop_table :house_committees
  end
end
