require File.expand_path("../environment", __FILE__)

job "scan.pub" do |args|
  # Scan.find(args["id"]).run
  Scan.pub
end

# beanstalkd
# stalk ./config/jobs.rb
# rails server