class StatusCode < ActiveRecord::Base
  set_primary_key "id"
  has_many :statuses
end
