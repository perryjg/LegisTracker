require 'bill_status_summary'

class Bill < ActiveRecord::Base
  has_many :statuses
  has_many :votes

  def self.reload_from_xml
    transaction do
      bills_summary = BillStatusSummary.new

      if bills_summary.response_success?
        self.connection.execute( 'DELETE from bills' )

        bills_summary.bills.each do |bill|
          create!(
            :id                => bill.Id,
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
        end
      end
     end
  end
end
