APP_PATH = File.expand_path('../..',  __FILE__)

God.watch do |w|
  w.dir = "#{APP_PATH}"
  w.name = "twubbles_stream"
  w.log = "/home/joan/hivepulse/shared/log/god-#{w.name}.log"
  w.pid_file = "/home/joan/hivepulse/shared/tmp/pids/#{w.name}.pid"
  w.env = {"RAILS_ENV" => "production", "PIDFILE" => w.pid_file}
  w.start = "bundle exec rake start_twubbles &"
  w.keepalive
end

God.watch do |w|
  w.dir = "#{APP_PATH}"
  w.name = "nyc_stream"
  w.log = "/home/joan/hivepulse/shared/log/god-#{w.name}.log"
  w.pid_file = "/home/joan/hivepulse/shared/tmp/pids/#{w.name}.pid"
  w.env = {"RAILS_ENV" => "production", "PIDFILE" => w.pid_file}
  w.start = "bundle exec rake start_nyc &"
  w.keepalive
end

God.watch do |w|
  w.dir = "#{APP_PATH}"
  w.name = "tech_companies_stream"
  w.log = "/home/joan/hivepulse/shared/log/god-#{w.name}.log"
  w.pid_file = "/home/joan/hivepulse/shared/tmp/pids/#{w.name}.pid"
  w.env = {"RAILS_ENV" => "production", "PIDFILE" => w.pid_file}
  w.start = "bundle exec rake start_tech_companies &"
  w.keepalive
end

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