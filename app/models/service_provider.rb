class ServiceProvider < ActiveRecord::Base
  field :company_name, :type => :string
  field :ico, :type => :string
  field :dic, :type => :string
  field :phone, :type => :string
  field :email, :type => :string
  field :street, :type => :string
  field :city, :type => :string
  field :zip, :type => :integer
  field :country, :type => :integer

  # ASSOCIATIONS
  has_many :provision_services, :dependent => :delete_all
  has_many :service_orders
  has_many :service_requests, :foreign_key => :product_category_id, :through => :provision_services, :source => :product_category , :class_name => 'ServiceRequest'

  #has_many :product_categories, :through => :provision_services
  # PERMISSION
  accepts_nested_attributes_for :provision_services
  attr_accessible :company_name, :ico, :dic, :email, :phone, :street, :city, :zip, :country, :provision_services_attributes
  #VALIDATIONS
  validates :company_name, :presence => true

  def to_s
    self.company_name
  end

end
ServiceProvider.auto_upgrade!