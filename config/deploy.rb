require 'bundler/capistrano' # for bundler support
require 'sidekiq/capistrano'
# require 'delayed/recipes'

set(:sidekiq_cmd) {"bundle exec sidekiq"}
set(:sidekiqctl_cmd) {"bundle exec sidekiqctl"}
set(:sidekiq_timeout) {10}
set(:sidekiq_role) {:app}
set(:sidekiq_pid) { "#{current_path}/tmp/pids/sidekiq.pid"}
set(:sidekiq_processes) {5}

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

namespace :god do
  task :watch do
    run "cd #{release_path} && #{try_sudo} god -c config/stream.god -D"
  end

  # task :start_nyc do
  #   run "cd #{release_path} && #{try_sudo} nohup rake twitter:start_nyc RAILS_ENV=production &"
  # end

  # task :start_beverag
end

#   task :redis does do
#   #   run "cd #{release_path} && #{try_sudo} nohup rake twitter:start_beverages RAILS_ENV=production &"
#   # end
#     run "cd #{release_path} && #{try_sudo} nohup redis-server /etc/redis/redis.conf"
#   end

#   task :sidekiq do
#     run "cd #{release_path} && #{try_sudo} bundle exec sidekiq -d -e production -P #{shared_path}/pids/sidekiq.pid -L #{release_path}/log/sidekiq.log"
#   end
# end

before "deploy:restart", "db:migrate"
# after "deploy:stop",    "delayed_job:stop"
# after "deploy:start",   "delayed_job:start"
# after "deploy:restart", "delayed_job:restart"
 
before "deploy:finalize_update", "deploy:symlink_keys"
before "deploy:finalize_update", "god:watch"
# before "deploy:restart", "async:redis"
# before "deploy:restart", "async:sidekiq"
# before "deploy:restart", "twitter:start_all"
# before "deploy:restart", "twitter:start_nyc"
# before "deploy:restart", "twitter:start_beverages"
        # require './config/boot'
        # require 'airbrake/capistrano'
