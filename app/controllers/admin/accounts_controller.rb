class Admin::AccountsController < Customer::AccountsController
  belongs_to :user

  protected

  def begin_of_association_chain
    nil
  end

end