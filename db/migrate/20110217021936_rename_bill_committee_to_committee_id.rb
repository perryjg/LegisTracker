class RenameBillCommitteeToCommitteeId < ActiveRecord::Migration
  def self.up
    rename_column :bills, :h_committee, :house_committee_id
    rename_column :bills, :s_committee, :senate_committee_id
  end

  def self.down
    rename_column :bills, :house_committee_id,  :h_committee
    rename_column :bills, :senate_committee_id, :s_committee
  end
end
