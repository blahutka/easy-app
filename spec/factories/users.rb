# encoding: utf-8

FactoryGirl.define do

  factory :user do

    factory :valid_user do
      email 'customer@easyservice.cz'
      password 'password'
      password_confirmation 'password'

      factory :valid_user_with_account do |f|
        f.account(:factory =>  :customer_account_no_validate )
      end

    end


  end

  factory :customer_account do

    factory :customer_account_no_validate do
      to_create {|instance| instance.save(:validate =>  false) }
    end

  end
end