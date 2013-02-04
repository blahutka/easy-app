class User < ActiveRecord::Base
  include User::Authentication

  field :email, :type => :string
  field :account_type, :type => :string
  field :account_id, :type => :integer
  field :admin, :type => :boolean, :default => false

  attr_protected :admin
  attr_accessor :new_password

  belongs_to :account, :polymorphic => true, :dependent => :destroy
  after_create :setup_account

  delegate :service_orders, :to => :account

  def setup_account
    unless self.account
      customer_account = CustomerAccount.new
      customer_account.save(:validate => false)
      self.account = customer_account
      self.save!
    end
  end

  def generate_credentials
    self.new_password = User.send(:generate_token, 'encrypted_password').slice(0, 8)
    self.email = self.account.email
    raise 'No account email set' if self.email.blank?
    self.password = self.new_password
    self.password_confirmation = self.new_password
  end

  def deliver_invitation
    Users::InvitationMailer.invite(self, self.new_password).deliver
  end
end

User.auto_upgrade!