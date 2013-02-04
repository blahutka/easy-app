class CustomerAccount < ActiveRecord::Base
  field :company_name, :type => :string
  field :ico, :type => :string
  field :dic, :type => :string
  field :first_name, :type => :string
  field :last_name, :type => :string
  field :phone, :type => :string
  field :email, :type => :string
  field :street, :type =>  :string
  field :city, :type => :string
  field :zip, :type => :integer
  field :country, :type => :string

  has_many :users, :as => :account
  has_many :service_orders, :dependent => :destroy

  attr_accessible :company_name, :dic, :ico, :first_name, :last_name, :phone, :email,:street, :city, :zip

  validates :first_name, :last_name, :phone, :email, :street, :city, :zip, :presence => true
  validates :zip, :length => { :maximum => 5, :numericality => true }
  validates :ico, :length => { :minimum => 7, :maximum => 9, :numericality => true, :allow_blank => true}

  def to_s
    [self.full_name, self.company_name, self.city].compact.join(', ')
  end

  def full_name
    [self.first_name, self.last_name].compact.join(' ')
  end

end

CustomerAccount.auto_upgrade!