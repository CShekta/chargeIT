class UsersController < ApplicationController
  before_action :require_login, only: [:show]

  # def new
  #   @user = User.new
  # end
  #
  # def create
  #   @user = User.new(user_params)
  #   if @user.save
  #     @user.latitude = @user.zip_code.to_lat
  #     @user.longitude = @user.zip_code.to_lon
  #     @user.save
  #     redirect_to new_session_path
  #   else
  #     render "new"
  #   end
  # end

  def show
    @user = User.find(@current_user.id)
  end

  private

  def user_params
    params.require(:resource).permit(:first_name, :last_name, :email, :zip_code, :password, :password_confirmation)
  end
end
