class CreateSponsorships < ActiveRecord::Migration
  def self.up
    create_table :sponsorships do |t|
      t.integer :bill_id
      t.integer :member_id
      t.integer :seq
    end
  end

  def self.down
    drop_table :sponsorships
  end
end
