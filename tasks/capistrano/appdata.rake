namespace :deploy do
namespace :appdata do

  task :setup do
    on roles(:app) do
      app_path = fetch(:deploy_to)

      # create shared dir
      #path = File.join app_path, 'shared'
      #execute "mkdir -p #{path}"

      app_env = fetch(:rails_env)

      d_repo = AppdataSettings.appdata_repo_path(release_path, app_env)
      git_repo = AppdataSettings.repo_app_site_data(app_env)
      execute "mkdir -p #{d_repo}"

      execute "cd #{d_repo} && git init"
      execute "cd #{d_repo} && git remote add origin #{git_repo}" rescue true

    end
  end


  ###

  task :upload do
    # variant. upload using local cache of git repo
    d_repo = AppdataSettings.appdata_repo_path(release_path, app_env)
    git_repo = AppdataSettings.repo_app_site_data(app_env)

    # init local repo
    %x(mkdir -p #{d_repo})
    %x(cd #{d_repo} && git init)
    %x(cd #{d_repo} && git remote add origin #{git_repo})

    # pull
    %x(cd #{d_repo} && git pull origin master)

    # copy
    AppSettings.site_app_data_dirs.each do |d|
      d_server_base = File.dirname(d)

      #puts "from #{d} to #{d_server_base}"
      #exit
      upload!(d+"/", "#{current_path}/"+d_server_base+"/", :recursive => true)
    end



    # variant1. upload directly to server
=begin
    on roles(:app) do
      AppSettings.site_app_data_dirs.each do |d|
        d_server_base = File.dirname(d)

        #puts "from #{d} to #{d_server_base}"
        #exit
        upload!(d+"/", "#{current_path}/"+d_server_base+"/", :recursive => true)
      end

      # commit to remote repo
      Rake::Task["deploy:appdata:server_save"].invoke

      #
      Rake::Task["deploy:restart"].invoke

    end
=end

  end


  task :server_save do
    on roles(:app) do
      e = fetch(:rails_env)

      execute "cd #{current_path} && RAILS_ENV=#{e} rake appdata:save"
    end
  end

  task :server_update do
    on roles(:web) do
      e = fetch(:rails_env)

      execute "cd #{current_path} && RAILS_ENV=#{e} rake appdata:update"

    end
  end




#### OLD
=begin
  task :server_save do
    on roles(:app) do
      p = File.join(shared_path, '..', 'repo-data')

      # rsync to repo-data
      #rsync -Lavrt --exclude-from '../{{server}}/files/rsync_exclude_list.txt' -e 'ssh -p {{ansible_ssh_port | default(22)}}'  {{root_user}}@{{inventory_hostname | quote}}:{{remote_path | quote}} {{backup_dir | quote }}
      #rsync -Lavrt --exclude-from '../{{server}}/files/rsync_exclude_list.txt' {{root_user}}@{{inventory_hostname}}:{{remote_path}} {{backup_dir}}


      # ok
      #execute "rsync -Lavrt --exclude-from '#{release_path}/.rsync_ignore' #{release_path}/ #{p}"

      # ok - app
      execute "rsync -Lavrt --exclude-from '#{release_path}/.rsync_ignore' #{release_path}/app/ #{p}/app"

      # commit & push to remote repo
      execute %Q(cd #{p} && git add . && git commit -m "server changes #{Time.now.utc}") rescue true
      execute %Q(cd #{p} && git push origin master) rescue true

      #git add -A .

    end
  end

  task :server_update do
    on roles(:web) do
      p = File.join(shared_path, '..', 'repo-data')
      execute %Q(cd #{p} && git pull origin master)
    end
  end

=end


end
end