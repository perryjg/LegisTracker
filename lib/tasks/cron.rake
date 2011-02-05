desc "Update data"
task :cron => :environment do
  if Time.now.hour == 7
    puts "Reloading data from XML"
    Bill.reload_from_xml
    Vote.reload_from_xml
    puts "Data loading complete."
  end

  puts "Updating RSS from feeds"
  HouseFeed.update_from_feed
  SenateFeed.update_from_feed
  "RSS updated"
end
