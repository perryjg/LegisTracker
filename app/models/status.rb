class Status < ActiveRecord::Base
  belongs_to :bill
  belongs_to :status_code
  
  def self.most_recent
    where( "DATE(status_date) = ?", last_date )
  end
  
  def self.find_for_date( date )
    where( "DATE(status_date) = ?", date )
  end
  
  def self.last_date
    maximum( "DATE(status_date)" )
  end
end
