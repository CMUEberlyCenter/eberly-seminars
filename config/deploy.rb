# ==|== capistrano deployment configuration ================================
# Author: Meg Richards (mouse@cmu.edu)
# ==========================================================================

# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'seminars'
set :repo_url, "file:///afs/andrew.cmu.edu/eberly/repo/#{fetch(:application)}/site.git"
set :scm, :git

set :deploy_to, "/srv/rails/#{fetch(:application)}"

set :linked_files, %w{config/database.yml config/initializers/secret_token.rb}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :default_env, { path: "/usr/local/rvm/bin/rvm:/srv/rails/seminars/shared/bin:$PATH" }

set :bundle_flags, '--deployment --local --quiet'
SSHKit.config.command_map[:rake]  = "bundle exec rake"
SSHKit.config.command_map[:rails] = "bundle exec rails"

set :rvm_ruby_string, :local              # use the same ruby as used locally for deployment
set :rvm_autolibs_flag, "read-only"       # more info: rvm help autolibs

#before 'deploy:setup', 'rvm:install_rvm'  # install/update RVM
#before 'deploy:setup', 'rvm:install_ruby' # install Ruby and create gemset, OR:


# ==|== utilities ==========================================================
desc 'Execute uname on application server'
task :uname do
  on roles(:app) do |host|
    execute :uname, '-a'
  end
end


# ==|== rails ==============================================================
# adjusted from https://gist.github.com/toobulkeh/8214198
namespace :rails do

  desc "Open the rails console on each of the remote servers"
  task :console do
    on primary :app do
      run_remote_pty "rails console #{fetch :stage}"
    end
  end
  
  desc "Open the rails dbconsole on each of the remote servers"
  task :dbconsole do
    on primary :db do
      run_remote_pty "rails dbconsole #{fetch :stage}"
    end
  end
  
  def run_remote_pty command
    exec "ssh #{host} -t 'cd #{deploy_to}/current && PATH=#{fetch(:default_env)[:path]} #{command}'"
  end
end


# ==|== deploy =============================================================
namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  before :restart, :fix_apache_permissions do
    on roles(:web) do
      # Where the assets get compiled to
      within shared_path do
        execute :chown, '-R www-data:www-data .'
      end
      # All new files
      within release_path do
        execute :chown, '-R www-data:www-data .'
      end
    end
  end

end


namespace :app do
  task :update_rvm_key do
    on roles(:app) do
      execute :gpg, "--keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3"
    end
  end
end
#before "rvm1:install:rvm", "app:update_rvm_key"
#before 'deploy', 'rvm1:install:rvm'  # install/update RVM
#before 'deploy', 'rvm1:install:ruby'
#before 'deploy', 'rvm1:alias:create'
#before 'deploy', 'rvm1:install:gems'
