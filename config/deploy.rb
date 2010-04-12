# Application Specific Details
set :application, "calling_tool"
set :deploy_to,  "/var/www/public_html/#{application}"

server "isisresearchgroup.com", :app, :web, :db, :primary => true

default_run_options[:ptr] = true # Ensure password prompt is prompt true
set :repository, 'git@isisresearchgroup.com:calling_tool.git' # your private/public url and user
set :scm, 'git' # scm utility name
set :branch, 'master' # remote branch
set :deploy_via, :copy # If you have public like github.com then use :remote_cache

set :user, 'obama'
set :admin_runner, 'obama'

namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  desc "Restart Application"    
  task :restart do
    #run "rake db:migrate --rakefile #{deploy_to}/current/Rakefile RAILS_ENV=production"
    
    # link restful authentication plugin
    run "rm -rf /var/www/public_html/#{application}/current/vendor/plugins/restful_authentication"
    run "ln -s /var/www/public_html/#{application}/shared/plugins/restful_authentication /var/www/public_html/#{application}/current/vendor/plugins/restful_authentication"
    
    # link open flash chart plugin
    run "rm -rf /var/www/public_html/#{application}/current/vendor/plugins/open_flash_chart"
    run "ln -s /var/www/public_html/#{application}/shared/plugins/open_flash_chart /var/www/public_html/#{application}/current/vendor/plugins/open_flash_chart"
    
    # link spreadsheets dir
    run "rm -rf /var/www/public_html/#{application}/current/public/spreadsheets"
    run "ln -s /var/www/public_html/#{application}/shared/spreadsheets /var/www/public_html/#{application}/current/public/spreadsheets"    
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end
end

