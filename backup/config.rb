# encoding: utf-8

##
# Backup v5.x Configuration
#
# Documentation: http://backup.github.io/backup
# Issue Tracker: https://github.com/backup/backup/issues

##

require_relative 'init'




# Config Options
#
# The options here may be overridden on the command line, but the result
# will depend on the use of --root-path on the command line.
#
# If --root-path is used on the command line, then all paths set here
# will be overridden. If a path (like --tmp-path) is not given along with
# --root-path, that path will use it's default location _relative to --root-path_.
#
# If --root-path is not used on the command line, a path option (like --tmp-path)
# given on the command line will override the tmp_path set here, but all other
# paths set here will be used.
#
# Note that relative paths given on the command line without --root-path
# are relative to the current directory. The root_path set here only applies
# to relative paths set here.
#
# ---
#
# Sets the root path for all relative paths, including default paths.
# May be an absolute path, or relative to the current working directory.
#
#root_path '.'

#
# Sets the path where backups are processed until they're stored.
# This must have enough free space to hold apx. 2 backups.
# May be an absolute path, or relative to the current directory or +root_path+.
#
# tmp_path  'my/tmp'
#
# Sets the path where backup stores persistent information.
# When Backup's Cycler is used, small YAML files are stored here.
# May be an absolute path, or relative to the current directory or +root_path+.
#
# data_path 'my/data'

##
# Utilities
#
# If you need to use a utility other than the one Backup detects,
# or a utility can not be found in your $PATH.
#
#   Utilities.configure do
#     tar       '/usr/bin/gnutar'
#     redis_cli '/opt/redis/redis-cli'
#   end

##
# Logging
#
# Logging options may be set on the command line, but certain settings
# may only be configured here.
#
#   Logger.configure do
#     console.quiet     = true            # Same as command line: --quiet
#     logfile.max_bytes = 2_000_000       # Default: 500_000
#     syslog.enabled    = true            # Same as command line: --syslog
#     syslog.ident      = 'my_app_backup' # Default: 'backup'
#   end
#
# Command line options will override those set here.
# For example, the following would override the example settings above
# to disable syslog and enable console output.
#   backup perform --trigger my_backup --no-syslog --no-quiet

##
# Component Defaults
#
# Set default options to be applied to components in all models.
# Options set within a model will override those set here.

  if $backup_config['s3']
    s3_config = $backup_config['s3']

    Storage::S3.defaults do |s3|
      s3.access_key_id = s3_config['access_key_id']
      s3.secret_access_key = s3_config['secret_access_key']
      s3.region = s3_config['region']
      s3.bucket = s3_config['bucket']

    end
  end


   Notifier::Mail.defaults do |mail|
     mail.on_success           = true
     mail.on_warning           = true
     mail.on_failure           = true

     # user
     if $backup_config['notify'] && $backup_config['notify']['mail']
       c = $backup_config['notify']['mail']

       mail.from                 = c['from']
       mail.to                   = c['to']
       #mail.cc                   = "cc@email.com"
       #mail.bcc                  = "bcc@email.com"
       mail.reply_to             = c['reply_to']
     end




     if $smtp_config
       c = $smtp_config

       # smtp
       mail.address              = c['address']
       mail.port                 = c['port']
       mail.domain               = c['domain']
       mail.user_name            = c['user_name']
       mail.password             = c['password']
       mail.authentication       = c['authentication']
       mail.encryption           = c['encryption']

     end

#     mail.address              = 'smtp.gmail.com'
#     mail.port                 = 587
#     mail.domain               = 'your.host.name'
#     mail.user_name            = 'sender@email.com'
#     mail.password             = 'my_password'
#     mail.authentication       = 'plain'
#     mail.encryption           = :starttls
   end


  Notifier::Slack.defaults do |p|
    if $backup_config['notify'] && $backup_config['notify']['slack']
      c = $backup_config['notify']['slack']

      p.on_success = c['success'].nil? ?  true : c['success']
      p.on_warning = c['warning'].nil? ?  true : c['warning']
      p.on_failure = c['failure'].nil? ?  true : c['failure']

      # The integration token
      p.webhook_url = c['webhook_url']
      p.channel = c['channel'] if c['channel']
      p.username = c['username'] if c['username']
    end

  end

##
# Preconfigured Models
#
# Create custom models with preconfigured components.
# Components added within the model definition will
# +add to+ the preconfigured components.
#
#   preconfigure 'MyModel' do
#     archive :user_pictures do |archive|
#       archive.add '~/pictures'
#     end
#
#     notify_by Mail do |mail|
#       mail.to = 'admin@email.com'
#     end
#   end
#
#   MyModel.new(:john_smith, 'John Smith Backup') do
#     archive :user_music do |archive|
#       archive.add '~/music'
#     end
#
#     notify_by Mail do |mail|
#       mail.to = 'john.smith@email.com'
#     end
#   end
