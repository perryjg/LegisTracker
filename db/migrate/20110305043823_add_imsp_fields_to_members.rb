class AddImspFieldsToMembers < ActiveRecord::Migration
  def self.up
    add_column :members, :imsp_member_id, :integer
    add_column :members, :total_instate_dollars, :integer
    add_column :members, :total_out_of_state_dollars, :integer
    add_column :members, :total_unknown_state_dollars, :integer
    add_column :members, :party_committee_dollars, :integer
    add_column :members, :leadership_committee_dollars, :integer
    add_column :members, :candidate_money_dollars, :integer
    add_column :members, :individual_dollars, :integer
    add_column :members, :unitemized_donation_dollars, :integer
    add_column :members, :non_contribution_dollars, :integer
    add_column :members, :institution_dollars, :integer
    add_column :members, :total_dollars, :integer
  end

  def self.down
    remove_column :members, :total_dollars
    remove_column :members, :institution_dollars
    remove_column :members, :non_contribution_dollars
    remove_column :members, :unitemized_donation_dollars
    remove_column :members, :individual_dollars
    remove_column :members, :candidate_money_dollars
    remove_column :members, :leadership_committee_dollars
    remove_column :members, :party_committee_dollars
    remove_column :members, :total_unknown_state_dollars
    remove_column :members, :total_out_of_state_dollars
    remove_column :members, :total_instate_dollars
    remove_column :members, :imsp_member_id
  end
end
