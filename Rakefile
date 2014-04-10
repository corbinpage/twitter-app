# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

namespace :twitter do
  desc "Start NYC Beverages Scan"
  task :start_nyc_beverages => :environment do
    s = Scan.new(category: "nyc_beverages")
    s.save
    s.run_twitter_stream_nyc_beverages_without_delay
    `cd ./ && RAILS_ENV=development bin/delayed_job -m -n 2 start`
  end

  desc "Start NYC Scan"
  task :start_nyc => :environment do
    s = Scan.new(category: "nyc")
    s.run_twitter_stream_nyc_without_delay
    `cd ./ && RAILS_ENV=development bin/delayed_job -m -n 2 start`
  end

  desc "Stop Scan"
  task :stop => :environment do
    `cd ./ && RAILS_ENV=development bin/delayed_job stop`
    `ps xu | grep delayed_job | grep monitor | grep -v grep | awk '{print $2}' | xargs kill`
  end
end


namespace :jobs do
  desc "Start workers"
  task :start_workers do
    `cd ./ && RAILS_ENV=development bin/delayed_job -m -n 2 start`
  end

  desc "Stop workers"
  task :stop_workers do
    `ps xu | grep delayed_job | grep monitor | grep -v grep | awk '{print $2}' | xargs kill`
    `cd ./ && RAILS_ENV=development bin/delayed_job stop`
  end
end
