class CreateHouseFeeds < ActiveRecord::Migration
  def self.up
    create_table :house_feeds do |t|
      t.string :title
      t.string :summary
      t.string :author
      t.string :url
      t.datetime :published_at
      t.string :guid

      t.timestamps
    end
  end

  def self.down
    drop_table :house_feeds
  end
end
