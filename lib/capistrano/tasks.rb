require 'capistrano/framework'
require 'capistrano/file-permissions'

# load all tasks
load File.expand_path('../tasks/*.rake', __FILE__)
