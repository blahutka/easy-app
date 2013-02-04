class Admin::UsersController < Admin::BaseController


  def index
    index! {}
  end

  def new
    new!
  end

  def create
    set_admin_user
    create! do |success, failure|
      success.html { redirect_to admin_users_path }
    end
  end

  def update
    set_admin_user
    update! do |success, failure|
      success.html { redirect_to admin_users_path }
    end
  end

  def send_new_password
    @user = User.find(params[:id])
    if @user.send_reset_password_instructions
      redirect_to admin_users_path, :notice => 'Reset password send ' +@user.email
    else
      redirect_to admin_users_path, :alert => 'Error to reset password for user ' +@user.email
    end

  end

  protected

  def collection
    @users ||= end_of_association_chain.paginate(:per_page => 20, :page => params[:page].presence || 1)
  end

  def set_admin_user
    is_admin = params[:user].delete(:admin)
    @user = (resource rescue build_resource)
    @user.admin = (is_admin == '1')
  end
end