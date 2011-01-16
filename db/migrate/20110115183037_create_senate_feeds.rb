class CreateSenateFeeds < ActiveRecord::Migration
  def self.up
    create_table :senate_feeds do |t|
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
    drop_table :senate_feeds
  end
end
