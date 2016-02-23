class UsersController < ApplicationController
  before_action :require_login, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_session_path
    else
      render "new"
    end
  end

  def show; end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :zip, :password, :password_confirmation)
  end
end
