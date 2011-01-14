class Status < ActiveRecord::Base
  belongs_to :bill
  belongs_to :status_code
  
  def self.most_recent
    where( "DATE(statusDate) = ?", last_date )
  end
  
  private
  def self.last_date
    maximum( "DATE(statusDate)" )
  end
end
