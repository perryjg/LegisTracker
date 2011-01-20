class Vote < ActiveRecord::Base
  belongs_to :bill
  
  def reload_from_xml
  end

  def self.most_recent
    where( "DATE(date) = ?", last_date )
  end
  
  def self.last_date
    maximum( "DATE(date)" )
  end
end
