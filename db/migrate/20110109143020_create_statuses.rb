class CreateStatuses < ActiveRecord::Migration
  def self.up
    create_table :statuses do |t|
      t.integer :bill_id
      t.datetime :statusDate
      t.string :statusCode
      t.string :AmSubDesc
    end
  end

  def self.down
    drop_table :statuses
  end
end
