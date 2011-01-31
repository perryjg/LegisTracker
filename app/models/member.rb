class Member < ActiveRecord::Base
  has_many :sponsorships
  has_many :bills, :through => :sponsorships
  
  def name
    "#{last_name}, #{first_name}"
  end
end
