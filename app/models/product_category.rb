class ProductCategory < ActiveRecord::Base
  field :name, :type => :string
  field :defect_help, :type => :text
  field :defect_template, :type => :text
  field :product_num_help, :type => :text
  field :serial_num_help, :type => :text

  # ASSOCIATIONS
  has_many :service_requests

  has_many :provision_services
  has_many :product_brands, :through => :provision_services , :uniq => true

  #accepts_nested_attributes_for :product_brands
  attr_accessible :name, :defect_help, :defect_template, :product_num_help, :serial_num_help

  def to_s
    self.name
  end

end

ProductCategory.auto_upgrade!