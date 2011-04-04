class User < ActiveRecord::Base
  has_many :watched_bills
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  acts_as_tagger

  def watched_bill_votes
    Vote.joins( "JOIN watched_bills ON votes.bill_id = watched_bills.bill_id" ).
         where( "watched_bills.user_id = ?", id ).
         order( "votes.date DESC" )
  end

  def watched_bill_statuses
    Status.joins( "JOIN watched_bills ON statuses.bill_id = watched_bills.bill_id" ).
           where( "watched_bills.user_id = ?", id ).
           order( "statuses.status_date DESC" )
  end

  def watched_bills
    Bill.joins( "Join watched_bills ON bills.id = watched_bills.bill_id" ).
         where( "watched_bills.user_id = ?", id )
  end
end
