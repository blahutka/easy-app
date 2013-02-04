FactoryGirl.define do

  factory :service_provider do
    company_name 'Electra s.r.o'
  end

  factory :provision_service do
    association(:service_provider)

  end

end