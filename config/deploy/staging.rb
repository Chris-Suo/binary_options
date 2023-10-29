# frozen_string_literal: true

set :stage, :staging
set :rails_env, :staging
set :nginx_server_name, '45.118.135.200'
set :deploy_to, '/home/badman/fruit-scents'

# l1jweb-staging
server '45.118.135.200', user: 'badman', roles: %w[app web db]
