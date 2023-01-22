class SecuredController < ApplicationController
  before_action :authorize_request

  private

    def authorize_request
      authorize_request = AuthorizationService.new(request.headers)
      @current_user = authorize_request.current_user
      unless @current_user
        render json: { error: 'User not exists' }, status: :unauthorized
      end
      @current_user
    rescue JWT::VerificationError, JWT::DecodeError
      render json: { error: 'Not Authenticated' }, status: :unauthorized
    end
end
