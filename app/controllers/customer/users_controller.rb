class Customer::UsersController < Customer::BaseController
  def edit
    @user = current_user
  end

  def update_password
    @user = User.find(current_user.id)
    if @user.update_with_password(params[:user])
      # Sign in the user by passing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to user_root_path
    else
      render "edit"
    end
  end
end