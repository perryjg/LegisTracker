class Status < ActiveRecord::Base
  belongs_to :bill
  
  def self.most_recent
    where( "statusDate = ?", last_date )
  end
  
  private
  def self.last_date
    maximum( :statusDate )
  end
end
