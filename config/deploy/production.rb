## Application deployment configuration
set :server,      'slic.shef.ac.uk'
set :user,        'sa_aca18hgw'
set :deploy_to,   -> { "/home/#{fetch(:user)}/slic" }
set :log_level,   :debug
set :rails_env,   'production'

## Server configuration
server fetch(:server), user: fetch(:user), roles: %w{web app db}

## Passenger configuration
set :passenger_restart_options, "#{fetch(:deploy_to)}/current --ignore-app-not-running --ignore-passenger-not-running"

## Additional tasks
namespace :deploy do
  task :seed do
    on primary :db do within current_path do with rails_env: fetch(:stage) do
      execute :rake, 'db:seed'
    end end end
  end
  task :clean do
    on primary :db do within current_path do with rails_env: fetch(:stage) do
      execute :rake, 'db:schema:load'
    end end end
  end
end
