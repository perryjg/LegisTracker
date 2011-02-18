class CreateBillVersions < ActiveRecord::Migration
  def self.up
    create_table :bill_versions do |t|
      t.integer :number
      t.integer :xmlid
      t.string  :description
      t.string  :fileid
      t.integer :bill_id
    end
  end

  def self.down
    drop_table :bill_versions
  end
end
