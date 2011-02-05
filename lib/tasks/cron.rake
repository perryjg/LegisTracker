desc "reload Bill and Vote tables from online xml"
task :relaod_from_xml => :environment do
  if Time.now.hour == 7
    puts "Reloading data from XML"
    Bill.reload_from_xml
    Vote.reload_from_xml
    puts "Data loading complete."
  end
end

desc "update House and Senate RSS data from feed"
task :update_from_feeds => :environment do
  puts "Updating RSS from feeds"
  HouseFeed.update_from_feed
  SenateFeed.update_from_feed
  "RSS updated"
end
