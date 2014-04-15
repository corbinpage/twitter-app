# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

namespace :twitter do
  desc "Start All Scans"
  task :start_all => :environment do
    system 'rake twitter:start_beverages RAILS_ENV=development &'
    system 'rake twitter:start_languages RAILS_ENV=development &'
    system 'rake twitter:start_tech_companies RAILS_ENV=development &'
    system 'rake twitter:start_nyc RAILS_ENV=development &'
  end

  desc "Start NYC Scan"
  task :start_nyc => :environment do
    s = Scan.new(category: "nyc")
    s.save
    s.run_twitter_stream_nyc_without_delay
    `bin/delayed_job --queue=nyc start`
  end

  desc "Start Beverages Scan"
  task :start_beverages => :environment do
    s = Scan.new(category: "beverages")
    s.save
    s.run_twitter_stream_beverages_without_delay
    `bin/delayed_job --queue=beverages start`
  end

  desc "Start Languages Scan"
  task :start_languages => :environment do
    s = Scan.new(category: "languages")
    s.save
    s.run_twitter_stream_languages_without_delay
    `bin/delayed_job --queue=languages start`
  end

  desc "Start Tech Companies Scan"
  task :start_tech_companies => :environment do
    s = Scan.new(category: "tech_companies")
    s.save
    s.run_twitter_stream_tech_companies_without_delay
    `bin/delayed_job --queue=tech_companies start`
  end

  desc "Stop Scan"
  task :stop => :environment do
    `bin/delayed_job stop`
    `ps xu | grep twitter:start | grep -v grep  | awk '{print $2}' | xargs kill`
  end

  # ----------For Production Use-------------

  desc "Start All Scans in Production"
  task :start_all_prod => :environment do
    system 'sudo rake twitter:start_beverages RAILS_ENV=production &'
    system 'sudo rake twitter:start_languages RAILS_ENV=production &'
    system 'sudo rake twitter:start_tech_companies RAILS_ENV=production &'
    system 'sudo rake twitter:start_nyc RAILS_ENV=production &'
  end

  desc "Stop Scans in Production"
  task :stop => :environment do
    `RAILS_ENV=production bin/delayed_job stop`
    `ps xu | grep twitter:start | grep -v grep  | awk '{print $2}' | xargs kill`
  end

end


namespace :jobs do
  desc "Start workers"
  task :start_workers do
    `RAILS_ENV=development bin/delayed_job -m -n 2 start`
  end

  desc "Stop workers"
  task :stop_workers do
    `ps xu | grep delayed_job | grep monitor | grep -v grep | awk '{print $2}' | xargs kill`
    `RAILS_ENV=development bin/delayed_job stop`
  end
end
