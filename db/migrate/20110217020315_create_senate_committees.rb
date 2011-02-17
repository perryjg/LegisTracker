class CreateSenateCommittees < ActiveRecord::Migration
  def self.up
    create_table :senate_committees do |t|
      t.string :name
      t.string :short_name, :limit => 10

      t.timestamps
    end
  end

  def self.down
    drop_table :senate_committees
  end
end
