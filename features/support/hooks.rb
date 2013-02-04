Before("@laboratory_user_logged_in") do
  steps %Q{ Given laboratory user is logged in }
  puts 'logged in laboratory user'
end

Before("@dentist_user_logged_in") do
  steps %Q{ Given dentist user is logged in }
  puts 'logged in dentist user'
end

Before '@logout_customer' do
  steps %Q{
  Given I am logged out
  }
  puts 'logged out user'
end