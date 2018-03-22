# config valid for current version and patch releases of Capistrano
lock "~> 3.10.1"

set :application, 'ViksTnetica17'
set :repo_url, 'git@github.com:vikkanaev/ViksTnetica17.git'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/deploy/ViksTnetica17"
set :deploy_user, 'deploy'

set :pty,  false

# Default value for :linked_files is []
append :linked_files, "config/database.yml", ".env", "config/production.sphinx.conf"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "public/uploads"

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
      execute('passenger-config restart-app /home/deploy/ViksTnetica17/current')
    end
  end

  after :publishing, :restart
end

namespace :sphinx do
  desc 'Start sphinx server'
  task :start do #4
    on roles(:app) do # 3
      within current_path do #2
        with rails_env: fetch(:rails_env) do #1
          execute :bundle, "exec rake ts:start"
        end #1
      end # 2
    end #3
  end #4

  desc 'Stop sphinx server'
  task :stop do
    on roles(:app) do
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, "exec rake ts:stop"
        end
      end
    end
  end

  desc 'Restart sphinx server'
  task :restart do
    on roles(:app) do
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, "exec rake ts:restart"
        end
      end
    end
  end

  after 'deploy:restart', 'sphinx:restart'
end
