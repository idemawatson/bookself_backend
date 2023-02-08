class Api::V1::UsersController < SecuredController
  def create
    User.create(params[:name], params[:email])
  end

  def show
    if params[:id] === "-1"
      logger.debug @current_user
      render json: @current_user
      return
    end
    @user = User.find_by(params[:id])
    render json: @user
  end
end
