class AppdataSettings

  def self.settings
    return @config if @config

    # load from yaml
    @config = YAML.load_file(filename_config)
    @config
  end

  def self.filename_config
    File.expand_path('../appdata.yml', __FILE__)
  end



  def self.deploy_dirs_exclude
    a1 = settings['site_user_data_dirs'] || []
    a2 = settings['site_app_data_dirs'] || []

    a1+a2
  end

  def self.appdata_repo_path(app_path, _env)
    e = _env
    dir_name = get_config_value("repo_app_data_dir_name", e)
    dir_base_path = get_config_value("repo_app_data_dir_base", e)

    d_repo = File.join(app_path, dir_base_path, dir_name)
  end


  def self.get_config_value(name, _env)
    e = _env
    e = 'default' unless e

    v = settings[e][name.to_s] || settings['default'][name.to_s] || settings[name]

    v
  end


  ###
  def self.method_missing(m, *args, &block)
    v = get_config_value(m.to_s, args[0])
    v
  end

end