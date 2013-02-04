class ProductBrand < ActiveRecord::Base
  field :name, :type => :string

  # ASSOCIATIONS
  has_many :service_requests
  has_many :provision_services
  has_many :product_categories, :through => :provision_services, :uniq => true

  attr_accessible :name

  default_scope :order => 'name'

  def to_s
    self.name
  end
end
ProductBrand.auto_upgrade!