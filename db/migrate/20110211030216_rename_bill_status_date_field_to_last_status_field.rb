class RenameBillStatusDateFieldToLastStatusField < ActiveRecord::Migration
  def self.up
    rename_column :bills, :status_date, :current_status_date
  end

  def self.down
    rename_column :bills, :current_status_date, :status_date
  end
end
