# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

namespace :db do
  desc "Reloads bill and vote data from Georgia Assembly XML file"
  task :reload_from_xml => :environment do
    Bill.reload_from_xml
    Vote.reload_from_xml
  end

  desc "Update House and Senate RSS feed data from feed"
  task :update_from_feeds => :environment do
    HouseFeed.update_from_feed
    SenateFeed.update_from_feed
  end
end

Legitracker::Application.load_tasks
