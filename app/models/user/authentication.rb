module User::Authentication
  extend ActiveSupport::Concern

  included do
    attr_accessor :login
    attr_accessible :login, :first_name, :last_name, :email, :password, :password_confirmation, :remember_me
    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable,
           :authentication_keys => [:email]

    ## Database authenticatable
    #field :email, :type => :string, :null => false, :default => ""
    field :encrypted_password, :type => :string, :null => false, :default => ""

    ## Recoverable
    field :reset_password_token, :type => :string
    field :reset_password_sent_at, :type => :datetime

    ## Rememberable
    field :remember_created_at, :type => :datetime

    ## Trackable
    field :sign_in_count, :default => 0, :type => :integer
    field :current_sign_in_at, :type => :datetime
    field :last_sign_in_at, :type => :datetime
    field :current_sign_in_ip, :type => :string
    field :last_sign_in_ip, :type => :string

    ## Encryptable
    field :password_salt, :type => :string

    ## Confirmable
    field :confirmation_token, :type => :string
    field :confirmed_at, :type => :datetime
    field :confirmation_sent_at, :type => :datetime
    #field :unconfirmed_email, :type => :string # Only if using reconfirmable

    ## Lockable
    # field :failed_attempts, :default => 0, :type => :integer # Only if lock strategy is :failed_attempts
    # field :unlock_token, :type => :string # Only if unlock strategy is :email or :both
    # field :locked_at, :type => :datetime

    # Token authenticatable
    field :authentication_token, :type => :string

    ## Invitable
    field :invitation_token, :field => :string

    add_index ["email"], :name => "index_users_on_email", :unique => true
    add_index ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

    def to_s
      [self.email].compact.join(', ')
    end
  end
end