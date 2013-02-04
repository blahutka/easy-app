FactoryGirl.define do
  factory :service_order do

  end

  factory :valid_service_order, :parent => :service_order do
    association :service_request, :factory => :valid_service_request
    association :customer_account
  end
end