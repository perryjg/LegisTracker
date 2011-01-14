class NormalizeStatusFieldNames < ActiveRecord::Migration
  def self.up
    rename_column :statuses, :statusDate, :status_date
    rename_column :statuses, :AmSubDesc, :am_sub_desc
  end

  def self.down
    rename_column :statuses, :status_date, :statusDate
    rename_column :statuses, :am_sub_desc, :AmSubDesc
  end
end
