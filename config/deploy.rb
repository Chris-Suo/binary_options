# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
# 3.11.0 (2018-06-02)
# lock "~> 3.11.0"

set :rvm_ruby_version, '3.2.2'
set :rvm1_ruby_version, '3.2.2'
set :rvm_type, :user
set :rvm1_map_bins, %w[rake gem bundle ruby rails puma pumactl]

set :application, 'binary_options'
#set :repo_url, 'git@github.com:mywarr/binary_options.git'

# Default branch is :master
set :branch, ENV['branch'] || 'master'

set :puma_user, fetch(:user)
set :puma_systemctl_user, :user # accepts :user
set :puma_workers, ENV.fetch('WEB_CONCURRENCY') { 1 }
set :puma_init_active_record, true
set :puma_preload_app, true
set :puma_tag, fetch(:application)

# Sidekiq service defaults
set :sidekiq_role, :app
set :sidekiq_env, fetch(:rack_env, fetch(:rails_env, fetch(:stage)))
set :sidekiq_processes, 1
set :init_system, :systemd
set :service_unit_name, 'sidekiq_binary_options.service'

append :linked_dirs,
       'log',
       'storage',
       'tmp/pids',
       'tmp/cache',
       'tmp/sockets',
       'public/system',
       'public/uploads',
       'public/packs',
       'public/assets',
       'node_modules'

# Default value for :linked_files is []
append :linked_files,
       'config/master.key',
       'config/database.yml'

# hotfix
Rake::Task["deploy:assets:backup_manifest"].clear_actions


