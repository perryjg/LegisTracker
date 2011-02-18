class BillVersion < ActiveRecord::Base
  belongs_to :bill
  
  scope :order_desc, order( "number DESC" )
  
  def url
    "http://www1.legis.ga.gov/legis/2011_12/versions/#{fileid}"
  end
  
  def self.latest
    order_desc.first
  end
end
