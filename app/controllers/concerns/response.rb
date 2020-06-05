module Response
  def json_response(object, message, status = :ok)
    render json: { data: object, message: message }, status: status
  end

  def error_json_response(message, status)
    render json: { status: "error", message: message }, status: status
  end
end
