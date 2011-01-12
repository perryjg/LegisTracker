class Status < ActiveRecord::Base
  belongs_to :bill
  
  def self.most_recent
    where( "DATE(statusDate) = ?", last_date )
  end
  
  private
  def self.last_date
    maximum( "DATE(statusDate)" )
  end
end
