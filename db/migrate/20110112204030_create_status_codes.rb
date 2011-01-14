class CreateStatusCodes < ActiveRecord::Migration
  def self.up
    create_table :status_codes do |t|
      t.string :id, :limit => 10
      t.string :description
      t.string :house, :limit => 1
      t.integer :seq
    end
  end

  def self.down
    drop_table :status_codes
  end
end
