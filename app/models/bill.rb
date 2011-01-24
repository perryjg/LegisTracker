require 'bill_status_summary'
require 'shellwords'

class Bill < ActiveRecord::Base
  has_many :statuses
  has_many :votes

  def self.reload_from_xml
    transaction do
      bills_summary = BillStatusSummary.new

      if bills_summary.response_success?
        self.connection.execute( 'DELETE from bills' )
        self.connection.execute( 'ALTER TABLE bills AUTO_INCREMENT = 1' )

        bills_summary.bills.each do |bill|
          create!(
            :xml_id            => bill.Id.to_i,
            :btype             => bill.Type,
            :num               => bill.Num,
            :suffix            => bill.Suffix,
            :carryover         => bill.Carryover,
            :year_id           => bill.YearID,
            :status_date       => bill.StatusDate,
            :number            => bill.Number,
            :short_title       => bill.Short_Title,
            :composite_caption => bill.CompositeCaption,
            :title             => bill.Title,
            :h_committee       => bill.HCommittee,
            :s_committee       => bill.SCommittee,
            :eff_date          => bill.EffDate,
            :b_status          => bill.BStatus,
            :footnote          => bill.Footnote,
            :code_title        => bill.Citation['codeTitle'],
            :code_chapter      => bill.Citation['codeChapter']
          )
          connection.execute( "UPDATE bills SET id = xml_id WHERE xml_id = #{bill.Id}" )

          bill.StatusHistory.each do |status|
            parent = find( bill.Id.to_i )
            parent.statuses.create!(
              :status_date    => status['StatusDate'],
              :status_code_id => status['StatusCode']
            )
          end
        end
      end
     end
  end

  def self.search( params )
    search_string = '%' + Shellwords.shellwords( params ).join( '%' ) + '%'
    where( "concat_ws( ' ', concat( btype, num ), number, title, b_status) LIKE ?", search_string )
  end
end
