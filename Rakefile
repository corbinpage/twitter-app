# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

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