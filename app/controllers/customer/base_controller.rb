class Customer::BaseController < ApplicationController
  inherit_resources
  before_filter :authenticate_user!


  protected

  def begin_of_association_chain
    current_account
  end

end