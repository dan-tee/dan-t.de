set :application, 'dan-t.de'

# remote repository name
set :repository, 'origin'
# repository url
set :repo_url, 'git@github.com:Dan-Tee/dan-t.de.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, '/usr/local/share/dan-t.de'
set :scm, :git
set :git_shallow_clone, 1

set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.0.0-p247'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} /usr/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

set I18n.enforce_available_locales, false

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5

namespace :deploy do

  before :deploy, :check_write_permissions
  before :deploy, :git_push

  after 'deploy:updating', 'link_database_config'
  after 'deploy:updating', 'link_dot_secret'
  after 'deploy:updating', 'link_admin_password_file'
  after :finishing, 'deploy:cleanup'

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # invoke passengers restart mechanism:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  [:start, :stop].each do |t|
    desc "#{t} does nothing for passenger"
    task t
      on roles :app do ; end
  end
end
