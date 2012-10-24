set :default_environment, {
  'PATH' => "/var/lib/gems/1.9.1/bin:$PATH"
}

set :stages, %w(development production)
set :default_stage, "development"
require 'capistrano/ext/multistage'

set :use_sudo, false
set :default_shell, "/bin/bash"

set :application, "seminars"
set :user, "www-data"
set :group, "www-data"

set :scm, :git
set :repository,  "file:///afs/andrew.cmu.edu/eberly/repo/seminars/site.git"
set :deploy_to, "/opt/rails/#{application}"
set :deploy_via, :remote_cache
set :rails_env, 'production'

task :uname do
  run "uname -a"
end

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end

  task :stop do ; end

  task :db_config, :except => { :no_release => true }, :role => :app do
    run "cp -f #{shared_path}/config/database.yml #{current_path}/config/database.yml"
  end

  #task :restart, :roles => :app, :except => { :no_release => true } do
  #  run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  #end
end

after "deploy:update", "deploy:db_config"
