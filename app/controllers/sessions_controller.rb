# class SessionsController < ApplicationController
#   def new; end
#
#   def create
#     data = params[:session_data]
#     @user = User.find_by_email(data[:email])
#
#     if !@user.nil?
#       if @user.authenticate(data[:password])
#         # user is authenticated
#         session[:user_id] = @user.id
#         redirect_to map_path
#       end
#     else
#       flash.now[:error] = "Incorrect email or password"
#       render :new
#     end
#   end
#
#   def destroy
#     session[:user_id] = nil
#     redirect_to map_path
#   end
# end
