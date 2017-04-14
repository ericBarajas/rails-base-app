#
set :log_level, :debug


#set :rvm_type, :system
set :rvm_type, :user
set :rvm_ruby_version, '2.3.3'




#
set :rsync_options, %w[
  --recursive --delete --delete-excluded
  --exclude .git*
  --exclude /test/***
]



role :app, %w{11.22.33.44}
role :web, %w{11.22.33.44}
role :db,  %w{11.22.33.44}


#
set :repo_url, 'ssh://git@github.com/myrepo.git'



#set :user, 'uadmin'
#set :group, 'dev'
set :deploy_user, 'app'

set :ssh_options, { forward_agent: true, user: 'app' }
#set :pty, true


# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 10



# Add necessary files and directories which can be changed on server.
my_config_dirs = %W{config config/environments}
my_config_files = %W{config/database.yml config/secrets.yml config/environments/#{fetch(:stage)}.rb }
my_app_dirs = AppdataSettings.deploy_dirs_exclude


# do not change below
set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle')
set :linked_dirs, fetch(:linked_dirs) + my_app_dirs
set :linked_files, fetch(:linked_files, []) + my_config_files

set :config_dirs,  my_config_dirs+my_app_dirs
set :config_files, my_config_files


# precompile assets - locations that we will look for changed assets to determine whether to precompile
set :assets_dependencies, %w(app/assets lib/assets vendor/assets Gemfile config/routes.rb)


namespace :deploy do
  namespace :assets do
    # precompile directly
    task :my_precompile do
      on roles(:app) do
        within "#{fetch(:deploy_to)}/current/" do
          #with RAILS_ENV: fetch(:environment) do
          with RAILS_ENV: fetch(:stage) do
            execute :rake, "assets:precompile"
          end
        end

        #execute "cd #{release_path} && rake assets:precompile RAILS_ENV=#{fetch(:stage)} "
        #execute "cd #{release_path} && RAILS_ENV=#{fetch(:stage)} bundle exec rake assets:precompile "

      end

      Rake::Task["deploy:restart"].invoke
    end

    desc "Precompile assets if changed"
    task :my_precompile_changed do
      on roles(:app) do
        invoke 'deploy:assets:precompile_changed'
        #Rake::Task["deploy:assets:precompile_changed"].invoke
      end
    end
  end
end




#
before "deploy", "deploy:web:disable"
after "deploy", "deploy:web:enable"

after "deploy", "deploy:restart"
