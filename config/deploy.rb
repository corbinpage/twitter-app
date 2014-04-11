require 'bundler/capistrano' # for bundler support
require "delayed/recipes"  

set :application, "hivepulse"
set :repository,  "git@github.com:joanieS/twitter-app.git"

set :user, 'joan'
set :deploy_to, "/home/#{ user }/#{ application }"
set :use_sudo, false

set :scm, :git

#Added for Delayed Job  
set :rails_env, "production"

default_run_options[:pty] = true

role :web, "107.170.117.122"                          # Your HTTP server, Apache/etc
role :app, "107.170.117.122"                          # This may be the same as your `Web` server

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
 task :start do ; end
 task :stop do ; end
 task :restart, :roles => :app, :except => { :no_release => true } do
   run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
 end
end

namespace :db do
	task :migrate do
		run "cd #{release_path} && #{try_sudo} rake db:migrate RAILS_ENV=production"
	end
end

namespace :twitter_prod do
  desc "Start NYC Beverages Scan"
  task :start_nyc_beverages => :environment do
    s = Scan.new(category: "nyc_beverages")
    s.save
    s.run_twitter_stream_nyc_beverages_without_delay
  end

  desc "Start NYC Scan"
  task :start_nyc => :environment do
    s = Scan.new(category: "nyc")
    s.run_twitter_stream_nyc_without_delay
  end

end


before "deploy:restart", "db:migrate"
after "deploy:stop",    "delayed_job:stop"
after "deploy:start",   "delayed_job:start"
after "deploy:restart", "delayed_job:restart"
after "delayed_job:start",   "twitter_prod:start_nyc"
