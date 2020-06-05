module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      error_json_response(e.message, :not_found)
    end
    rescue_from ActiveRecord::RecordInvalid, with: :error_message_422
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :error_message_422
    rescue_from ExceptionHandler::InvalidToken, with: :error_message_422
  end

  private

  def error_message_422(e)
    error_json_response(e.message, :unprocessable_entity)
  end

  def unauthorized_request(e)
    error_json_response(e.message, :unauthorized)
  end
end
