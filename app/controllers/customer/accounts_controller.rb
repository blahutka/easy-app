class Customer::AccountsController < Customer::BaseController
  defaults :singleton => true
  #after_filter :continue_with_order, :only => [:update]

  def update
    update! do |success|
      success.html { continue_with_order_or_show_account }
    end
  end

  protected

  def begin_of_association_chain
    current_user
  end

  def continue_with_order_or_show_account
    if @service_request = ServiceRequest.find_by_session_id(service_request_id)
      if @account.valid?
        redirect_to(customer_service_request_path(@service_request)) and return
      else
        render('edit')
      end
    else
      redirect_to(customer_account_path)
    end

  end
end