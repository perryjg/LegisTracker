class SenateCommittee < ActiveRecord::Base
  has_many :bills
end
