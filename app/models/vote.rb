require 'votes_summary'

class Vote < ActiveRecord::Base
  belongs_to :bill
  has_many :member_votes
  acts_as_taggable_on :key
  
  scope :hot_bills, joins( "JOIN bills ON bills.id = votes.bill_id JOIN taggings ON taggable_id = bills.id AND taggable_type = 'Bill'" ).
                    where( "taggings.context = 'hot'")
  scope :order_by_datetime_desc, order( "date DESC" )
  
  def self.most_recent
    where( "DATE(date) = ?", last_date )
  end

  def self.most_recent_vote
    order( 'date DESC' ).limit(1)
  end
  
  def self.find_for_date( date )
    where( "DATE(date) = ?", date )
  end
  
  def self.last_date
    maximum( "DATE(date)" )
  end
  
  def self.key
    tagged_with( 'key' )
  end
  
  def is_key?
    key_list.include?( 'key' )
  end
  
  def is_hot_bill?
    bill.is_hot?
  end
  
  def self.reload_from_xml
    transaction do
      ['house','senate'].each do |house|
        votes_summary = VotesSummary.new( house )

        if votes_summary.response_success?
          votes_summary.vote_details.each do |v|
            next if v.caption == "MORNING ROLL CALL"
            unless exists? :xml_id => v.id
              bill = Bill.find_by_number( v.legislation )
              bill_id = bill.nil? ? nil : bill.id

              new_vote = create!(
                :branch      => v.branch,
                :xml_id      => v.id,
                :legislation => v.legislation,
                :date        => v.dateTime,
                :description => v.caption,
                :unknown     => v.unknown,
                :excused     => v.excused,
                :not_voting  => v.send('not-voting'),
                :nay         => v.nays,
                :yea         => v.yeas,
                :bill_id     => bill_id
              )
              v.members.each do |m|
                next if m['name'] == 'VACANT'
                member = Member.find_by_vote_id_string( m['name'] )
                
                member_vote = MemberVote.new
                member_vote.member_id = member.id
                member_vote.vote_id   = new_vote.id
                member_vote.vote_cast = m['vote']
                member_vote.bill_id = bill_id unless bill_id.blank?
                member_vote.save
              end
            end
          end
        end
      end
    end
  end
end
