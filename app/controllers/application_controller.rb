class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_error_response404
  rescue_from ActiveRecord::RecordInvalid, with: :render_error_response400

  # 省略

  def render_error_response404(exception)
    logger.error exception
    error = { status: 404, type: "not-found", title: 'not found' }
    render json: error, status: :not_found
  end

  def render_error_response400(exception)
    logger.error exception
    error = { status: 400, type: "invalid-request", title: 'invalid request' }
    render json: error, status: :bad_request
  end
end
