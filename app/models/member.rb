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
