json.extract! user, :id, :username, :password, :quota, :level, :active, :created_at, :updated_at
json.url user_url(user, format: :json)
