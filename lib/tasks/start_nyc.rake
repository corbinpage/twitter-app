task :start_nyc => :environment do
  File.open(ENV["PIDFILE"], 'w') { |f| f << Process.pid } if ENV["PIDFILE"]
  Scan.create(category: 'nyc').run_twitter_stream_nyc
end