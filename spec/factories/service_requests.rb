FactoryGirl.define do
  factory :service_request do

  end

  factory :valid_service_request, :parent => :service_request do
    serial_num '1232111'
  end

  factory :invalid_service_request, :parent => :service_request do
    serial_num nil
  end

end