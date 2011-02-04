desc "reload Bill and Vote tables from online xml"
task :relaod_from_xml => :environment do
  if Time.now.hour == 7
    Bill.reload_from_xml
    Vote.reload_from_xml
  end
end

desc "update House and Senate RSS data from feed"
task :update_from_feeds => :environment do
  HouseFeed.update_from_feed
  SenateFeed.update_from_feed
end
