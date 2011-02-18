require 'bill_status_summary'
require 'shellwords'

class Bill < ActiveRecord::Base
  acts_as_taggable_on :hot, :topics
  
  belongs_to :house_committee
  belongs_to :senate_committee
  has_many :statuses
  has_many :bill_versions
  has_many :votes
  has_many :member_votes
  has_many :sponsorships
  has_many :members, :through => :sponsorships
  search_methods :sponsor_name, :sponsor_district, :sponsor_party, :default_order

  scope :sponsor_name, lambda { |name|
    joins("join sponsorships on sponsorships.bill_id = bills.id join members on members.id = sponsorships.member_id").
    where( "sponsorships.seq = 1 and concat_ws( ' ', members.last_name, members.first_name ) like ?", "%#{name}%" )
  }

  scope :sponsor_district, lambda { |dist|
    joins("join sponsorships on sponsorships.bill_id = bills.id join members on members.id = sponsorships.member_id").
    where( "sponsorships.seq = 1 and concat( members.house, members.district ) = ?", dist )
  }

  scope :sponsor_party, lambda { |party|
    joins("join sponsorships on sponsorships.bill_id = bills.id join members on members.id = sponsorships.member_id").
    where( "sponsorships.seq = 1 and members.party = ?", party )
  }
  
  def house_committee_name
    house_committee.committee_name
  end
  
  def senate_committee_name
    senate_committee.committee_name
  end
  
  def sponsor_count
    sponsorships.count
  end
  
  def primary_sponsor
    sponsorships.primary.first
  end

  def primary_sponsor_name
    primary_sponsor.member.name
  end

  def primary_sponsor_district
    "#{primary_sponsor.member.house}#{primary_sponsor.member.district}"
  end

  def primary_sponsor_party
    primary_sponsor.member.party
  end
  
  def self.hot
    scoped
    tagged_with( 'hot' )
  end
  
  def is_hot?
    hot_list.include?( 'hot' )
  end

  def self.reload_from_xml
    transaction do
      bills_summary = BillStatusSummary.new

      if bills_summary.response_success?
        self.connection.execute( 'DELETE from bills' )
        self.connection.execute( 'ALTER TABLE bills AUTO_INCREMENT = 1' )
        self.connection.execute( 'DELETE from sponsorships' )
        self.connection.execute( 'ALTER TABLE sponsorships AUTO_INCREMENT = 1' )
        self.connection.execute( 'DELETE from statuses' )
        self.connection.execute( 'ALTER TABLE statuses AUTO_INCREMENT = 1' )
        self.connection.execute( 'DELETE from bill_versions' )
        self.connection.execute( 'ALTER TABLE bill_versions AUTO_INCREMENT = 1' )

        bills_summary.bills.each do |bill|
          create!(
            :xml_id            => bill.Id.to_i,
            :btype             => bill.Type,
            :num               => bill.Num.to_i,
            :suffix            => bill.Suffix,
            :carryover         => bill.Carryover.to_i,
            :year_id           => bill.YearID.to_i,
            :current_status_date  => bill.StatusDate,
            :number            => bill.Number,
            :short_title       => bill.Short_Title,
            :composite_caption => bill.CompositeCaption,
            :title             => bill.Title,
            :house_committee_id   => bill.HCommittee.to_i,
            :senate_committee_id  => bill.SCommittee.to_i,
            :eff_date          => bill.EffDate,
            :b_status          => bill.BStatus,
            :footnote          => bill.Footnote,
            :code_title        => bill.Citation['codeTitle'].to_i,
            :code_chapter      => bill.Citation['codeChapter'].to_i
          )
          connection.execute( "UPDATE bills SET id = xml_id WHERE xml_id = #{bill.Id}" )

          bill.StatusHistory.each do |status|
            parent = find( bill.Id.to_i )
            parent.statuses.create!(
              :status_date    => status['StatusDate'],
              :status_code_id => status['StatusCode']
            )
          end
          
          bill.Sponsors.each do |s|
            Sponsorship.create!(
              :bill_id   => bill.Id.to_i,
              :member_id => s['Id'],
              :seq       => s['Seq']
            )
          end
          
          bill.version_data_array.each do |v|
            BillVersion.create!(
              :bill_id => v[0],
              :number => v[1],
              :xmlid => v[2],
              :description => v[3],
              :fileid => v[4]
            )
          end
        end
      end
     end
  end
end
