require 'bundler/capistrano' # for bundler support
require "delayed/recipes"  

set :application, "hivepulse"
set :repository,  "git@github.com:twizards/twitter-app.git"

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
 task :symlink_keys do
 	run "#{try_sudo} ln -s #{shared_path}/application.yml #{release_path}/config/application.yml"
 end
end

namespace :db do
  task :migrate do
    run "cd #{release_path} && #{try_sudo} rake db:migrate RAILS_ENV=production"
  end
end

namespace :twitter do
  task :start_nyc do
    run "cd #{release_path} && #{try_sudo} rake twitter:start_nyc RAILS_ENV=production &"
  end

  task :start_beverages do
    run "cd #{release_path} && #{try_sudo} rake twitter:start_beverages RAILS_ENV=production &"
  end
end

before "deploy:restart", "db:migrate"
# after "deploy:stop",    "delayed_job:stop"
# after "deploy:start",   "delayed_job:start"
# after "deploy:restart", "delayed_job:restart"
 
before "deploy:finalize_update", "deploy:symlink_keys"
before "deploy:restart", "db:migrate"
before "deploy:restart", "twitter:start_nyc"
before "deploy:restart", "twitter:start_beverages"