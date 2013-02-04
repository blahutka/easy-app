class ServiceOrder < ActiveRecord::Base
  field :customer_account, :type => :references
  field :service_provider, :type => :references
  field :service_request, :type => :references
  field :state, :type => :string, :default => 'new'
  field :created_at, :type => :datetime
  field :updated_at, :type => :datetime

  # ASSOCIATIONS
  belongs_to :customer_account
  belongs_to :service_provider
  belongs_to :service_request
  # PERMISSIONS
  accepts_nested_attributes_for :service_request
  attr_accessible :service_request_attributes, :service_provider_id, :state

  # VALIDATIONS
  validates :customer_account_id, :presence => true

  delegate :company_name, :first_name, :last_name, :street, :city, :zip,
           :to => :customer_account, :prefix => :customer, :allow_nil => true
  delegate :company_name, :ico, :dic, :phone, :street, :city, :zip,
           :to => :service_provider, :prefix => :provider, :allow_nil => true
  delegate :serial_num, :product_num, :service_type, :pickup_date_1, :pickup_time_1,
           :product_brand, :product_category, :defect_description,
           :to => :service_request, :prefix => :request, :allow_nil => true
  # SCOPES
  scope :multi_type, lambda { |t| self.search(t.first => t.last).where(nil) if t.size > 1 }

  # SEARCH METHODS META SEARCH
  search_methods :multi_type #, :splat_param => true, :type => [:string, :string]

  def available_service_providers
    ServiceProvider.includes(:provision_services).
        where(:provision_services => {:product_category_id => self.service_request.product_category_id,
                                      :product_brand_id => self.service_request.product_brand_id }
    ) if self.service_request
  end

  def to_s
    "##{self.id} #{self.request_product_category}, #{self.request_product_brand}"
  end


end

ServiceOrder.auto_upgrade!