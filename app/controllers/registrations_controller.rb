class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    super
    @user = User.new(sign_up_params)
    if @user.save
      @user.latitude = @user.zip_code.to_lat
      @user.longitude = @user.zip_code.to_lon
      @user.save
      redirect_to "/map"
    # else
    #   redirect_to "/users/sign_up"
    end
  end

  def update
    super
  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :telephone, :zip_code)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :telephone, :zip_code, :current_password)
  end
end
