class AddCrossoverFieldToBills < ActiveRecord::Migration
  def self.up
    add_column :bills, :crossover, :boolean, :default => 0
  end

  def self.down
    remove_column :bills, :crossover
  end
end
