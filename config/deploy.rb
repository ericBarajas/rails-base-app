# config valid only for current version of Capistrano
lock '3.4.0'

set :rvm_ruby_version, '2.1.5'
set :rvm_type, :user

#
set :rsync_options, %w[
  --recursive --delete --delete-excluded
  --exclude .git*
  --exclude /test/***
]



#set :user, 'uadmin'
#set :group, 'dev'
set :deploy_user, 'uadmin'

role :app, %w{11.22.33.44}
role :web, %w{11.22.33.44}
role :db,  %w{11.22.33.44}



set :repo_url, 'ssh://myserver.com/repos/sitename.git'
#set :repo_url, '.'

# set in :stage file
#set :application, 'appname'


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
set :keep_releases, 25


#
set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle')
set :linked_dirs, fetch(:linked_dirs) + %w{public/system public/img public/uploads app/views}
filename_env = "config/environments/#{fetch(:stage)}.rb"
set :linked_files, fetch(:linked_files, []).push(filename_env, 'config/database.yml', 'config/secrets.yml')

set :config_dirs, %W{config config/environments/#{fetch(:stage)} public/system public/uploads public/img}
set :config_files, %w{config/database.yml config/secrets.yml}
set :config_files, fetch(:config_files, []).push(filename_env)


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

namespace :deploy do
  task :mycheck do
    on roles(:app) do
      warn 'PLATFORM='+RUBY_PLATFORM
      if RUBY_PLATFORM =~ /(win32)|(i386-mingw32)/
        warn '-------- winda'
      else
      end
    end
  end

end




=begin
namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

=end




#
#before "deploy", "deploy:web:disable"
#after "deploy", "deploy:web:enable"
