class CreateBills < ActiveRecord::Migration
  def self.up
    create_table :bills do |t|
      t.string    :btype
      t.integer   :num
      t.string    :suffix
      t.integer   :carryover
      t.integer   :yearID
      t.date      :statusDate
      t.string    :number
      t.string    :short_title
      t.string    :compositeCaption
      t.text      :title	
      t.integer   :hCommittee
      t.integer   :sCommittee
      t.date      :EffDate
      t.string    :BStatus
      t.string    :statusCode
      t.text      :Footnote
      t.integer   :codeTitle
      t.integer   :codeChapter
    end
  end

  def self.down
    drop_table :bills
  end
end
