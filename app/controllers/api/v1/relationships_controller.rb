class Api::V1::RelationshipsController < SecuredController
  def create
    if @current_user.follwing?
      render json: { type: "duplicate-follow", title: "既にフォロー済みです", status: 400 }, status: :bad_request
    end
    @current_user.relationships.create(followed_id: params[:user_id])
    render json: { result: "ok" }
  end

  def accept
    @relationships = @current_user.relationships.find_by(follower_id: params[:follower_id])
    @relationships.update_attributes(accepted: true)
    render json: { result: "ok" }
  end

  def deny
    @current_user.relationships.find_by(followed_id: params[:user_id]).destroy
    render json: { result: "ok" }
  end

  def followings
    @followings = @current_user.followings
    render json: @followings
  end

  def followers
    @followers = @current_user.followers
    render json: @followers
  end
end
