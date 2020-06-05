class ApplicationController < ActionController::API
  before_action :authorize_user
  attr_reader :current_user

  private

  def authorize_user
    @current_user = AuthorizeApiRequest.new(request.headers).call[:user]
  end
end
