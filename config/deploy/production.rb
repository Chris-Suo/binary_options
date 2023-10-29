# frozen_string_literal: true

set :stage, :production
set :rails_env, :production
set :nginx_server_name, '15.235.112.103'
set :deploy_to, '/home/ubuntu/www'

# l1jweb-production
server '15.235.112.103', user: 'ubuntu', roles: %w[app web db]
