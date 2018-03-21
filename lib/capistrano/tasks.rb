require 'capistrano/framework'
require 'capistrano/file-permissions'

# load all tasks
# Dir.glob('./tasks/*.rake').each { |task| load File.expand_path(task)}
load File.expand_path('../tasks/composer.rake', __FILE__)
load File.expand_path('../tasks/phpfpm.rake', __FILE__)
load File.expand_path('../tasks/react.rake', __FILE__)
load File.expand_path('../tasks/permissions.rake', __FILE__)
load File.expand_path('../tasks/supervisor.rake', __FILE__)
load File.expand_path('../tasks/migrate.rake', __FILE__)
load File.expand_path('../tasks/db_scripts.rake', __FILE__)
load File.expand_path('../tasks/goose_migrate.rake', __FILE__)