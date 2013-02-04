namespace :guard do
  desc 'Run Guard livereload for designers'
  task :livereload do
    %x[bundle exec guard -g design]
  end
end