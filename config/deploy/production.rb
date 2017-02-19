set :application, "tpl_demo"
set :rails_env, 'production'
set :branch, 'master'

set :deploy_to, "/var/www/apps/#{fetch(:application)}"

