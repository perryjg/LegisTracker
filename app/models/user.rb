class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  acts_as_tagger

  def watched_bills
    Bill.joins( "JOIN taggings ON bills.id = taggings.taggable_id" ).
         where( "taggings.context = 'hot' AND taggings.tagger_id = ?", id )
  end

  def watched_bill_votes
    Vote.joins( "JOIN taggings ON votes.bill_id = taggings.taggable_id" ).
         where( "taggings.context = 'hot' AND taggings.tagger_id = ?", id ).
         order( "date DESC" )
  end

  def watched_bill_statuses
    Status.joins( "JOIN taggings ON statuses.bill_id = taggings.taggable_id" ).
           where( "taggings.context = 'hot' AND taggings.tagger_id = ?", id ).
           order( "status_date DESC" )
  end
end
