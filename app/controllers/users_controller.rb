class UsersController < ApplicationController
  skip_before_action :authorize_user, :check_admin, only: [:user_login, :create]
  include Response
  include ExceptionHandler

  def user_login
    auth = AuthenticateUser.new(accept_params[:email], accept_params[:password]).call
    json_response({ token: auth }, "User logged in successfully")
  end

  def create
    create_user = User.create!(email: accept_params[:email], password: accept_params[:password])
    create_token = JsonWebToken.encode(user_id: create_user.id)
    json_response({ token: create_token }, "User created successfully", :created)
  end


  private

  def accept_params
    params.permit(:email, :password)
  end
end
