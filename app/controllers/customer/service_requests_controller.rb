class Customer::ServiceRequestsController < Public::ServiceRequestsController
  before_filter :authenticate_user!
  inherit_resources
  defaults :finder => :find_by_session_id!

  def create
    create!
  end

  def update
    update!
  end

end