class RenameStatusFieldStatusCodeToStatusCodeId < ActiveRecord::Migration
  def self.up
    change_column :statuses, :statusCode, :string, :limit => 10
    rename_column :statuses, :statusCode, :status_code_id
  end

  def self.down
    change_column :statuses, :status_code_id, :string, :limit => 255
    rename_column :statuses, :status_code_id, :statusCode
  end
end
