# sync
namespace :appdata do

  # get from remote repo and copy to the project/application
  task :update do
    #
    d_repo = AppdataSettings.appdata_repo_path(Rails.root, Rails.env)


    # init repo
    Rake::Task["appdata:repo:setup"].invoke


    # update repo first
    Rake::Task["appdata:repo:pull"].invoke

    # copy to project
    AppdataSettings.site_app_data_dirs.each do |d|
      d_from = File.join(d_repo, d)

      d_to = File.join(Rails.root, d)
      d_to_base = File.dirname(d_to)

      puts "copy from #{d_from} to #{d_to}"
      #in #{d_to_parent}

      FileUtils.mkdir_p d_to

      # copy dir
      FileUtils.cp_r d_from, d_to_base
      #FileUtils.copy_entry d_from, d_to_parent
      #FileUtils.cp_r d_from, Rails.root
    end


  end

  # save current data to remote repo
  task :save do
    # init repo
    Rake::Task["appdata:repo:setup"].invoke

    # update repo first
    Rake::Task["appdata:repo:pull"].invoke

    #
    d_repo = AppdataSettings.appdata_repo_path(Rails.root, Rails.env)


    # rsync to repo-data
    #rsync -Lavrt --exclude-from '../{{server}}/files/rsync_exclude_list.txt' -e 'ssh -p {{ansible_ssh_port | default(22)}}'  {{root_user}}@{{inventory_hostname | quote}}:{{remote_path | quote}} {{backup_dir | quote }}
    #rsync -Lavrt --exclude-from '../{{server}}/files/rsync_exclude_list.txt' {{root_user}}@{{inventory_hostname}}:{{remote_path}} {{backup_dir}}


    # ok
    #execute "rsync -Lavrt --exclude-from '#{release_path}/.rsync_ignore' #{release_path}/ #{p}"

    # ok - app
    #execute "rsync -Lavrt --exclude-from '#{release_path}/.rsync_ignore' #{release_path}/app/ #{p}/app"
    #%x[rsync -Lavrt --exclude-from '#{d}/.rsync_ignore' #{d}/ #{p}/ ]

    # check if rsync available
    output = %x(which rsync)
    res_rsync = output.strip.delete(" \t\r\n")

    AppdataSettings.site_app_data_dirs.each do |d|
      d_from = File.join(Rails.root, d)

      d_to = File.join(d_repo, d)
      d_to_base = File.dirname(d_to)

      puts "copy from #{d_from} to #{d_to}"

      FileUtils.mkdir_p d_to

      # rsync or copy
      if res_rsync!=""
        cmd = %Q(rsync -Lavrt #{d_from}/ #{d_to}/)
        puts "#{cmd}"
        %x(#{cmd})
      else
        # no rsync
        puts "no rsync. copying..."

        FileUtils.cp_r d_from, d_to_base
      end
    end



    # repo
    Rake::Task["appdata:repo:commit_push"].invoke


  end


  ### operations with repo

  namespace :repo do
    task :setup do
      d_repo = AppdataSettings.appdata_repo_path(Rails.root, Rails.env)

      #
      FileUtils.mkdir_p(d_repo) unless File.directory?(d_repo)

      # init local git repo
      repo_url = AppdataSettings.repo_app_site_data
      %x[cd #{d_repo} && git init ]
      %x[cd #{d_repo} && git remote add origin  #{repo_url} ] rescue nil
      %x[cd #{d_repo} && git remote set-url origin  #{repo_url} ]

    end


    task :pull do
      #
      d_repo = AppdataSettings.appdata_repo_path(Rails.root, Rails.env)

      %x[cd #{d_repo} && git pull origin master]
    end

    task :commit_push do
      #
      d_repo = AppdataSettings.appdata_repo_path(Rails.root, Rails.env)

      # commit & push to remote repo
      %x[cd #{d_repo} && git add . && git commit -m "server changes #{Time.now.utc}" ] rescue true
      %x[cd #{d_repo} && git push origin master] rescue true

      #git add -A .
    end
  end



end
