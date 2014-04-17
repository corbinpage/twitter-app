task :start_tech_companies => :environment do
  File.open(ENV["PIDFILE"], 'w') { |f| f << Process.pid } if ENV["PIDFILE"]
  Scan.create(category: 'tech_companies').run_twitter_stream_tech_companies
end