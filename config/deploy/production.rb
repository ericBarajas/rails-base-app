set :log_level, :debug

﻿set :application, 'myapp'
set :rails_env, 'production'
set :branch, "master"

# rvm
set :rvm_type, :system
set :rvm_ruby_version, '2.4.5'


# server
host = 'mysite.com'
ssh_port = 22
u = 'myuser'
pwd = 'mypwd'



set :deploy_user, u


server host, user: u, password: pwd, port: ssh_port, roles: %w{web app}, primary: true

set :deploy_to, "/home/app/apps/#{fetch(:application)}"

set :ssh_options, { forward_agent: true, paranoid: false, user: u,  password: pwd }