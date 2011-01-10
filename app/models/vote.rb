class Vote < ActiveRecord::Base
  belongs_to :bill
  
  def self.most_recent
    where( "date = ?", last_date )
  end
  
  private
  def self.last_date
    maximum( :date )
  end
end
