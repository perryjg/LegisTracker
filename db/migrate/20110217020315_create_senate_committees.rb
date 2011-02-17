class CreateSenateCommittees < ActiveRecord::Migration
  def self.up
    create_table :senate_committees do |t|
      t.string :committee_name
      t.string :committee_short_name, :limit => 10

      t.timestamps
    end
  end

  def self.down
    drop_table :senate_committees
  end
end
