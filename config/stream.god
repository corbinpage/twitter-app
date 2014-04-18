APP_PATH = File.expand_path('../..',  __FILE__)

def generic_monitoring(w, options = {memory_usage: 80.percent, memory_limit: 500.megabytes})
  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 10.seconds
      c.running = false
    end
  end
  
  w.restart_if do |restart|
    restart.condition(:memory_usage) do |c|
      c.above = options[:memory_limit]
      c.times = [3, 5] # 3 out of 5 intervals
    end
  
    restart.condition(:cpu_usage) do |c|
      c.above = options[:cpu_limit]
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


God.watch do |w|
  w.dir = "#{APP_PATH}"
  w.name = "twubbles_stream"
  w.log = "/home/joan/hivepulse/shared/log/god-#{w.name}.log"
  w.pid_file = "/home/joan/hivepulse/current/tmp/pids/#{w.name}.pid"
  w.env = {"RAILS_ENV" => "production", "PIDFILE" => w.pid_file}
  w.start = "bundle exec rake start_twubbles RAILS_ENV=production"
  w.keepalive
  w.restart_if do |restart|
    restart.condition(:cpu_usage) do |c|
      c.above = 50.percent
      c.times = 5
    end

    restart.condition(:memory_usage) do |c|
      c.above = 500.megabytes
      c.times = [4, 5] # 4 out of 5 intervals
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

God.watch do |w|
  w.dir = "#{APP_PATH}"
  w.name = "nyc_stream"
  w.log = "/home/joan/hivepulse/shared/log/god-#{w.name}.log"
  w.pid_file = "/home/joan/hivepulse/current/tmp/pids/#{w.name}.pid"
  w.env = {"RAILS_ENV" => "production", "PIDFILE" => w.pid_file}
  w.start = "bundle exec rake start_nyc RAILS_ENV=production"
  w.keepalive
end

God.watch do |w|
  w.dir = "#{APP_PATH}"
  w.name = "tech_companies_stream"
  w.log = "/home/joan/hivepulse/shared/log/god-#{w.name}.log"
  w.pid_file = "/home/joan/hivepulse/current/tmp/pids/tech_companies_stream.pid"
  w.env = {"RAILS_ENV" => "production", "PIDFILE" => w.pid_file}
  w.start = "bundle exec rake start_tech_companies RAILS_ENV=production"
  w.keepalive
end

#!/usr/bin/env ruby
# RAILS_ROOT = File.expand_path('../../', __FILE__)
# require 'rails/commands'
# require 'pry-nav'
# binding.pry


# God.watch do |w|
#   w.name = "test_angel"
#   w.group = "stream"
#   w.start = "#{RAILS_ROOT}/app/angels/test_angel.rb"
#   w.start_grace = 10.seconds
#   w.keepalive
# end

# God.watch do |w|
#   w.name = "nyc_angel"
#   w.group = "stream"
#   w.start = "#{Rails.root}/app/angels/nyc_angel.rb"
#   w.start_grace = 10.seconds
#   w.keepalive
# end

# God.watch do |w|
#   w.name = "tech_company_angel"
#   w.group = "stream"
#   w.start = "#{Rails.root}/app/angels/tech_company_angel.rb"
#   w.start_grace = 10.seconds
#   w.keepalive
# end