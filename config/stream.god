APP_PATH = File.expand_path('../..',  __FILE__)

God.watch do |w|
  w.name = "twubbles_stream"
  w.start = "bundle exec rake start_twubbles RAILS_ENV=production"
  generic_monitoring(w)
end

God.watch do |w|
  w.name = "nyc_stream"
  w.start = "bundle exec rake start_nyc RAILS_ENV=production"
  generic_monitoring(w)
end

God.watch do |w|
  w.name = "tech_companies_stream"
  w.start = "bundle exec rake start_tech_companies RAILS_ENV=production"
  generic_monitoring(w)
end

def generic_monitoring(w)
  w.dir = "#{APP_PATH}"
  w.group = "streams"
  w.log = "/home/joan/hivepulse/shared/log/god-#{w.name}.log"
  w.pid_file = "/home/joan/hivepulse/current/tmp/pids/#{w.name}.pid"
  w.env = {"RAILS_ENV" => "production", "PIDFILE" => w.pid_file}
  w.keepalive
  
  w.restart_if do |restart|
    restart.condition(:memory_usage) do |c|
      c.above = 500.megabytes
      c.times = [4, 5] # 4 out of 5 intervals
    end
  
    restart.condition(:cpu_usage) do |c|
      c.above = 80.percent
      c.times = 5
    end
  end
  
  w.lifecycle do |on|
    on.condition(:flapping) do |c|
      c.to_state = [:start, :restart]
      c.times = 5
      c.within = 5.minute
      c.transition = :unmonitored
      c.retry_in = 10.minutes
      c.retry_times = 5
      c.retry_within = 2.hours
    end
  end
end