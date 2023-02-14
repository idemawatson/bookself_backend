class Api::V1::UsersController < SecuredController
  def create
    User.create(params[:name], params[:email])
  end

  def show
    if params[:id] == "-1"
      render json: @current_user, serializer: ProfileSerializer
      return
    end
    @user = User.find_by(params[:id])
    render json: @user, each_serializer: ProfileSerializer
  end

  def index
    unless params[:q]
      render json: { status: 400, type: "invalid-request", title: 'invalid request' }
      return
    end
    @users = User.where('name LIKE ?', "%#{params[:q]}%").where.not(id: @current_user.id)
    render json: @users, each_serializer: UserSerializer, scope: { current_user: @current_user }
  end
end
