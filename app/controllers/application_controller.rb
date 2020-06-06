class ApplicationController < ActionController::API
  before_action :authorize_user, :check_admin
  attr_reader :current_user

  private

  def authorize_user
    @current_user = AuthorizeApiRequest.new(request.headers).call[:user]
  end

  def check_admin
    if current_user.role != "admin"
      error_json_response("you are not authorized to perform this operation", :unauthorized)
    end
  end
end
