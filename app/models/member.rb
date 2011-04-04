class Member < ActiveRecord::Base
  has_many :sponsorships
  has_many :member_votes
  has_many :bills, :through => :sponsorships
  
  scope :democrats,   where( :party => 'D' )
  scope :republicans, where( :party => 'R' )
  scope :find_by_party, lambda { |party| where( "party = ?", party ) }
  scope :reps,     where( :house => 'H' )
  scope :senators, where( :house => 'S' )
  scope :find_by_house, lambda { |house| where( "house = ?", house ) }
  
  def name
    "#{last_name}, #{first_name}"
  end
  
  def display_name
    "#{first_name} #{last_name}"
  end
  
  def district_name
    "#{house}#{district}"
  end
  
  def primary_sponsorships
    sponsorships.primary
  end
  
  def secondary_sponsorships
    sponsorships.secondary
  end

  def percent_in_state
    total_instate_dollars / total_dollars.to_f * 100
  end

  def percent_out_of_state
    total_out_of_state_dollars / total_dollars.to_f * 100
  end
  
  def percent_unknown_state
    total_unknown_state_dollars / total_dollars.to_f * 100
  end

  def contributions_by_geography
    [percent_in_state, percent_out_of_state, percent_unknown_state]
  end

  def percent_party_committee
    party_committee_dollars / total_dollars.to_f * 100
  end
  
  def percent_leadership_committee
    leadership_committee_dollars / total_dollars.to_f * 100
  end

  def percent_self_finance
    candidate_money_dollars / total_dollars.to_f * 100
  end

  def percent_individuals
    individual_dollars / total_dollars.to_f * 100
  end

  def percent_institutions
    institution_dollars / total_dollars.to_f * 100
  end

  def percent_unitemized
    unitemized_donation_dollars / total_dollars.to_f * 100
  end

  def percent_noncontribution_income
    non_contribution_dollars / total_dollars.to_f * 100
  end

  def contributions_by_source
    [percent_individuals, percent_institutions, percent_party_committee, percent_leadership_committee,
     percent_self_finance, percent_noncontribution_income, percent_unitemized]
  end
  
  def top_contributors
    begin
      imsp_member_id ? GovKit::FollowTheMoney::Contribution.top( imsp_member_id ) : nil
    rescue
      nil
    end
  end
  
  def contributions_by_sector
    begin
      imsp_member_id ? GovKit::FollowTheMoney::SectorContribution.find( imsp_member_id ) : nil
    rescue
      nil
    end
  end
  
  def contributions_by_industry
    begin
      imsp_member_id ? GovKit::FollowTheMoney::IndustryContribution.find( imsp_member_id ) : nil
    rescue
      nil
    end
  end
  
  def contributions_by_business
    begin
      imsp_member_id ? GovKit::FollowTheMoney::BusinessContribution.find( imsp_member_id ) : nil
    rescue
      nil
    end
  end

  def pvs_bio
    begin
      pvs_member_id ? GovKit::VoteSmart::Bio.find( pvs_member_id ) : nil
    rescue
      nil
    end
  end

  def pvs_address
    begin
      pvs_member_id ? GovKit::VoteSmart::Address.find( pvs_member_id ) : nil
    rescue
      nil
    end
  end
  
  def self.load_imsp_data
    [ 'HOUSE', 'SENATE' ].each do |house|
      puts "Getting #{house} candidates"
      candidates = GovKit::FollowTheMoney::Candidate.list( :state => 'GA', :year => '2010', :office => house, :status => 'WON' )
      candidates.each do |c|
        member = Member.find_by_imsp_member_id( c.imsp_candidate_id )
        next if member.nil?
        member.total_instate_dollars        = c.total_in_state_dollars
        member.total_out_of_state_dollars   = c.total_out_of_state_dollars
        member.total_unknown_state_dollars  = c.total_unknown_state_dollars
        member.party_committee_dollars      = c.party_committee_dollars
        member.leadership_committee_dollars = c.candidate_leadership_committee_dollars
        member.candidate_money_dollars      = c.candidate_money_dollars
        member.individual_dollars           = c.individual_dollars
        member.unitemized_donation_dollars  = c.unitemized_donation_dollars
        member.non_contribution_dollars     = c.non_contribution_income_dollars
        member.institution_dollars          = c.institution_dollars
        member.total_dollars                = c.total_dollars
        member.save
      end
      sleep 2
    end
  end
end
