require "rubygems"
require "bundler"
Bundler.require(:default, :db_seed)

require Rails.root.join('spec/factories/users')
require Rails.root.join('spec/factories/product_categories')
require Rails.root.join('spec/factories/product_brands')
require Rails.root.join('spec/factories/service_orders')
require Rails.root.join('spec/factories/service_requests')
include FactoryGirl::Syntax::Methods

Rake::Task['mini_record:migrate'].invoke

STDOUT.puts "This seed will clean your DB !!"
STDOUT.puts "Continue ? (y/n)"
input = Rails.env.production? ? STDIN.gets.strip : 'y'

if input =~ /y|yes/
  DatabaseCleaner.clean_with(:truncation)

  puts '*'*10
  puts 'START'

  DB_CATEGORIES = []
  DB_BRANDS = []

  User.where(admin: true).first_or_create!(email: 'admin@easyservice.cz',
                                           password: 'password', password_confirmation: 'password')

  user = create(:valid_user)


  CATEGORIES.each do |name, data|
    brands = data.delete(:brands)
    DB_CATEGORIES << category = ProductCategory.where(name: name).first_or_create!(data)

    brands.each do |brand_name|
      brand = ProductBrand.where(name: brand_name).first_or_create!
    #  category.product_brands << brand
    #  category.save(:validate => false)
      DB_BRANDS << brand
    end

    @service_order = create(:valid_service_order,
                            :customer_account => user.account,
                            :service_request => create(:valid_service_request,
                                                       :product_category => DB_CATEGORIES.sample,
                                                       :product_brand => DB_BRANDS.sample))
  end

  service_provider = ServiceProvider.where(:company_name => 'Electra s.r.o').
      first_or_create!(:street => 'Height 542 ', :city => 'New York', :email => 'info@electra.cz', :phone => '776 042 112')

  provision_service = service_provider.provision_services.
      create!(:product_category_id => @service_order.service_request.product_category,
              :product_brand_id => @service_order.service_request.product_brand,
              :percentage => 2)


  puts 'END'
  puts '*'*10
end

