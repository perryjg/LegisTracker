class NormalizeBillFieldNames < ActiveRecord::Migration
  def self.up
    rename_column :bills, :yearID, :year_id
    rename_column :bills, :statusDate, :status_date
    rename_column :bills, :compositeCaption, :composite_caption
    rename_column :bills, :hCommittee, :h_committee
    rename_column :bills, :sCommittee, :s_committee
    rename_column :bills, :EffDate, :eff_date
    rename_column :bills, :BStatus, :b_status
    rename_column :bills, :statusCode, :status_code_id
    rename_column :bills, :Footnote, :footnote
    rename_column :bills, :codeTitle, :code_title
    rename_column :bills, :codeChapter, :code_chapter
  end

  def self.down
    rename_column :bills, :year_id, :yearID
    rename_column :bills, :status_date, :statusDate
    rename_column :bills, :composite_caption, :compositeCaption
    rename_column :bills, :h_committee, :hCommittee
    rename_column :bills, :s_committee, :sCommittee
    rename_column :bills, :eff_date, :EffDate
    rename_column :bills, :b_status, :BStatus
    rename_column :bills, :status_code_id, :statusCode
    rename_column :bills, :footnote, :Footnote
    rename_column :bills, :code_title, :codeTitle
    rename_column :bills, :code_chapter, :codeChapter
  end
end
