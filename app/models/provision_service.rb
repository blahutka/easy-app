# encoding: utf-8
class ProvisionService < ActiveRecord::Base
  field :product_category, :type => :references
  field :product_brand, :type => :references
  field :service_provider, :type => :references
  field :primary_provider, :type => :boolean, :default => false
  field :percentage, :type => :integer
  field :money, :type => :decimal
  timestamps

  # ASSOCIATIONS
  belongs_to :product_category
  belongs_to :product_brand
  belongs_to :service_provider
  has_many :service_requests, :primary_key => :product_category_id, :foreign_key => :product_category_id, :include => :service_order,
           :conditions => proc { "product_brand_id = #{product_brand_id} AND
                                  service_orders.service_provider_id is null" }

  has_many :service_orders, :primary_key => :service_provider_id, :foreign_key => :service_provider_id, :include => :service_request,
           :conditions => proc { "service_requests.product_brand_id = #{product_brand_id} AND
                                service_requests.product_category_id = #{product_category_id}" }

  attr_accessible :percentage, :money, :product_brand_id, :product_category_id, :primary_provider, :service_provider_id

  # VALIDATIONS
  validates :product_category_id, :product_brand_id, :service_provider_id, :presence => true
  validates :product_brand_id, :uniqueness => {:scope => [:product_category_id, :service_provider_id],
                                               :message => 'Tato položka v kategorii pro poskytovatele již existuje'}

  validates :primary_provider, :uniqueness => {:scope => [:product_category_id, :product_brand_id, :primary_provider],
                                               :unless => Proc.new { |obj| obj.primary_provider == false },
                                               :message => 'Tato služba se již poskytuje jinou firmou'}

  # ProvisionService.where(:product_category_id => obj.product_category_id,
  #                                                  :product_brand_id => obj.product_brand_id, :primary_provider => true ).first.
  #                                                     service_provider.to_s
  # SCOPES
  scope :available, where(:service_provider => nil)
end
ProvisionService.auto_upgrade!