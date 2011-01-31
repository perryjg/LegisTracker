class Sponsorship < ActiveRecord::Base
  belongs_to :bill
  belongs_to :member
  
  scope :primary, where( "seq = 1" )
  scope :secondary, where( "seq != 1" )
end
