require 'votes_summary'

class Vote < ActiveRecord::Base
  belongs_to :bill
  
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

              create!(
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
            end
          end
        end
      end
    end
  end

  def self.most_recent
    where( "DATE(date) = ?", last_date )
  end
  
  def self.find_for_date( date )
    where( "DATE(date) = ?", date )
  end
  
  def self.last_date
    maximum( "DATE(date)" )
  end
end
