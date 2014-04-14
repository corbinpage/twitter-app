# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

namespace :twitter do
  desc "Start All Scans"
  task :start_all => :environment do
    system 'rake twitter:start_tech_companies &'
    system 'rake twitter:start_nyc &'
    system 'rake twitter:start_beverages &'
    system 'rake twitter:start_languages &'

  end

  desc "Start NYC Scan"
  task :start_nyc => :environment do
    s = Scan.new(category: "nyc")
    s.save
    s.run_twitter_stream_nyc_without_delay
    `cd ./ && RAILS_ENV=development bin/delayed_job --queue=beverages start`
  end

  desc "Start Beverages Scan"
  task :start_beverages => :environment do
    s = Scan.new(category: "beverages")
    s.save
    s.run_twitter_stream_beverages_without_delay
    `cd ./ && RAILS_ENV=development bin/delayed_job --queue=beverages start`
  end

  desc "Start Languages Scan"
  task :start_languages => :environment do
    s = Scan.new(category: "languages")
    s.save
    s.run_twitter_stream_languages_without_delay
    `cd ./ && RAILS_ENV=development bin/delayed_job --queue=languages start`
  end

  desc "Start Tech Companies Scan"
  task :start_tech_companies => :environment do
    s = Scan.new(category: "tech_companies")
    s.save
    s.run_twitter_stream_tech_companies_without_delay
    `cd ./ && RAILS_ENV=development bin/delayed_job --queue=tech_companies start`
  end

  desc "Stop Scan"
  task :stop => :environment do
    `cd ./ && RAILS_ENV=development bin/delayed_job stop`
    `ps xu | grep delayed_job | grep monitor | grep -v grep | awk '{print $2}' | xargs kill`
  end

  # ----------For Production Use-------------

  desc "Start NYC Beverages Scan in Production"
  task :start_prod_nyc => :environment do
    s = Scan.new(category: "nyc_beverages")
    s.save
    s.run_twitter_stream_nyc_without_delay
    `cd ./ && RAILS_ENV=production bin/delayed_job start`
  end

  desc "Start NYC Scan in Production"
  task :start_prod_nyc => :environment do
    s = Scan.new(category: "nyc")
    s.run_twitter_stream_nyc_without_delay
    `cd ./ && RAILS_ENV=production bin/delayed_job start`
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
