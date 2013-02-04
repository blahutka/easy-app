namespace :mail do
  desc 'Run mailchatcher local mail delivery'
  task :run do
    puts 'To see emails'
    puts 'go to http://localhost:1080/'
     %x[mailcatcher]
  end
end