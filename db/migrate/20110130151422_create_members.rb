class CreateMembers < ActiveRecord::Migration
  def self.up
    create_table :members do |t|
      t.string :last_name
      t.string :first_name
      t.integer :district
      t.string :house, :limit => 1
      t.string :party, :limit => 1
      t.string :seat, :limit => 4
      t.string :vote_id_string
    end
  end

  def self.down
    drop_table :members
  end
end
