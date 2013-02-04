set :application, "easyservice"
set :repository,  "/usr/local/www/easyservice_cz_stage/"

set :scm, :git

role :app, ""                          # This may be the same as your `Web` server


# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

namespace :deploy do

  task :default do
    update
  end

  task :update do
    #system 'git push origin master '
    run "cd #{repository} && #{sudo} rm public/assets/application* && #{sudo} rake RAILS_ENV=production RAILS_GROUPS=assets assets:precompile:all"
  end

  task :start do ; end

end