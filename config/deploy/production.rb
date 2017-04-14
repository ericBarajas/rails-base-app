set :application, 'myapp'
set :rails_env, 'production'
set :branch, "master"


set :log_level, :debug

#
server_ip = '11.22.33.44'
server_user = 'app'
server_pwd = 'pass'
server_ssh_port = 22



#
role :app, [server_ip]
role :web, [server_ip]
role :db,  [server_ip]


#
set :deploy_user, 'app'


# rvm
set :rvm_type, :system                     # Defaults to: :auto
#set :rvm_ruby_version, '2.0.0-p247'      # Defaults to: 'default'
#set :rvm_custom_path, '~/.myveryownrvm'  # only needed if not detected


#
server server_ip, user: server_user, roles: %w{web}, primary: true, port: server_ssh_port

set :deploy_to, "/path/to/apps/#{fetch(:application)}"


set :ssh_options, { forward_agent: true, user: server_user, password: server_pwd}

