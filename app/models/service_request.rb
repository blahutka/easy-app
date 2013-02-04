class ServiceRequest < ActiveRecord::Base
  extend FriendlyId
  field :serial_num, :type => :string
  field :product_num, :type => :string
  field :session_id, :type => :string
  field :service_type, :type => :boolean
  field :pickup_info, :type => :text
  field :product_category, :type => :references
  field :product_brand, :type => :references
  field :defect_description, :type => :text
  field :defect_description_edited, :type => :boolean, :default => false
  field :slug, :type => :string

  friendly_id :session_id, use: :slugged

  # ASSOCIATIONS
  has_one :service_order
  belongs_to :product_category
  belongs_to :product_brand

  attr_accessor :user, :customer_account, :switch

  attr_accessible :serial_num, :product_num, :service_type, :pickup_info, :product_category_id,
                  :product_brand_id, :defect_description, :service_order_id, :defect_description_edited

  attr_accessible :user, :customer_account, :switch

  validates :serial_num, :product_category_id, :product_brand_id, :presence => true

  def to_s
    [self.service_type, self.product_category, self.product_brand].compact.join(', ')
  end
end

ServiceRequest.auto_upgrade!