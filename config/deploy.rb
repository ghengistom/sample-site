set :application, "apdf-examples"
set :repository,  "git@activepdf.unfuddle.com:activepdf/ex.git"

set :deploy_to, "/opt/examples/"
set :copy_exclude, ".git/*"
set :deploy_via, :copy
set :branch, 'master'

set :user, "deploy"

set :normalize_asset_timestamps, false

set :use_sudo, false
default_run_options[:pty] = true

ssh_options[:keys] = ["~/.ssh/id_rsa"]
ssh_options[:keys_only] = true
# ssh_options[:verbose] = :debug

set :scm, :git

role :web, "107.170.153.226"                          # Your HTTP server, Apache/etc
role :app, "107.170.153.226"                          # This may be the same as your `Web` server
role :db,  "107.170.153.226", :primary => true        # This is where Rails migrations will run

# Passenger
namespace :deploy do
  after "deploy:finalize_update", "deploy:bundle"
  
  task :start do; end
  task :stop do; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
    # `curl -sX PUT -d "user=#baddogs&message=The examples site has been updated! http://examples.activepdf.com/" http://baddog.ianneubert.com/baddog/say`
  end
  
  task :bundle do
    run "cd #{current_release}; bundle install --without development:test --path vendor/bundle"
    run "ln -s #{deploy_to}/#{shared_dir}/production.sqlite3 #{current_release}/db/production.sqlite3"
    # sudo "/etc/init.d/nginx stop"
    run "cd #{current_release}; bundle exec rake assets:precompile"
    run "cd #{current_release}; RAILS_ENV=production bundle exec rake db:migrate"
  end
  
  desc "Deploy to a fresh new server"
  task :cold do
    rails_env = fetch(:rails_env, "production")

    update
    run "cd #{deploy_to}/current; RAILS_ENV=#{rails_env} rake db:load"
    migrate
    restart
  end
end