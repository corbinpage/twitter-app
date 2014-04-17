task :start_twubbles => :environment do
  File.open(ENV["PIDFILE"], 'w') { |f| f << Process.pid } if ENV["PIDFILE"]
  Scan.create(category: 'twubbles').run_twitter_stream_twubbles
end