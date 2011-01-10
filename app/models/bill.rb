class Bill < ActiveRecord::Base
  has_many :statuses
  has_many :votes
end
