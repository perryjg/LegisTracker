class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.string :house, :limit => 1
      t.datetime :date
      t.string :type, :limit => 2
      t.integer :num
      t.string :description
      t.integer :yea
      t.integer :nay
      t.integer :not_voting
      t.integer :excused
    end
  end

  def self.down
    drop_table :votes
  end
end
