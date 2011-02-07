class Member < ActiveRecord::Base
  has_many :sponsorships
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
end
