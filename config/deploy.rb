set :application, "profile-edit-dev"
set :repo_url, "https://github.com/sul-dlss/profile-edit.git"
set :user, "bibframe"

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"
set :deploy_to, "/opt/app/#{fetch(:user)}/#{fetch(:application)}"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
set :linked_dirs, ['source/profiles']

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :npm_target_path, -> { release_path.join('source') } # default not set
# set :npm_flags, '--production --silent --no-progress'    # default
set :npm_flags, '--silent --no-progress'    # default
set :npm_roles, :all                                     # default
set :npm_env_variables, {}                               # default

namespace :deploy do
  desc "Start server"
  after :finished, :restart do
    on roles(:app) do
      execute "ln -s #{fetch(:application)}/current profile-edit"
      within release_path do
        execute "cd #{release_path.join('source')} && grunt --force"
      end
    end
  end
end
