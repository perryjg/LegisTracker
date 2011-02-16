class MemberVote < ActiveRecord::Base
  belongs_to :bill
  belongs_to :member
  belongs_to :vote
  
  delegate :party, :name, :display_name, :district_name, :to => :member
  delegate :number, :to => :bill
  
  scope :democrat, lambda {
    joins( "join members on member_votes.member_id = members.id" ).
    where( "members.party = ?", 'D' )
  }
  scope :republican, lambda {
    joins( "join members on member_votes.member_id = members.id" ).
    where( "members.party = ?", 'R' )
  }
  scope :by_party, lambda { |party|
    joins( "join members on member_votes.member_id = members.id" ).
    where( "members.party = ?", party )
  }
  scope :yea, where( :vote => 'Y' )
  scope :nay, where( :vote => 'N' )
end
