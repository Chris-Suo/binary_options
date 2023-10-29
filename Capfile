# frozen_string_literal: true

# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'

# Load the SCM plugin appropriate to your project:
require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

# Include tasks from other gems included in your Gemfile
set :application, 'binary_options'
require 'rvm1/capistrano3'
require 'capistrano/rails'

require 'capistrano/puma'
install_plugin Capistrano::Puma # Default puma tasks
install_plugin Capistrano::Puma::Systemd
install_plugin Capistrano::Puma::Workers # if you want to control the workers (in cluster mode)

require 'capistrano/sidekiq'
install_plugin Capistrano::Sidekiq
install_plugin Capistrano::Sidekiq::Systemd


# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
# Dir.glob("lib/capistrano/tasks/**/*.rake").each { |r| import r }
