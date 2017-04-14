# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

# appdata settings
require_relative 'config/appdata/appdata_settings'

Dir.glob('tasks/*.rake').each { |r| load r}
Dir.glob('tasks/**/*.rake').each { |r| load r}

Rake.add_rakelib 'tasks'

Rails.application.load_tasks
