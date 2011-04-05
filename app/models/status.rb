class Status < ActiveRecord::Base
  belongs_to :bill
  belongs_to :status_code
  delegate :hot_list, :to => :bill
  
  scope :hot, joins( "JOIN bills ON statuses.bill_id = bills.id JOIN taggings ON taggings.taggable_id = bills.id" ).
              where( "taggings.context = 'hot'" )
  scope :by_date_desc, order( "status_date DESC" )

  def self.most_recent
    find_for_date( last_date )
  end

  def self.most_recent_status
    order( 'status_date DESC' ).first
  end
  
  def self.find_for_date( date )
    where( "DATE(status_date) = ?", date )
  end
  
  def self.last_date
    maximum( "DATE(status_date)" )
  end
end
