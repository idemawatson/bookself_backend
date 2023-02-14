class Api::V1::RelationshipsController < SecuredController
  rescue_from ActiveRecord::RecordNotUnique, with: :render_error_not_unique

  def render_error_not_unique(exception)
    logger.error exception
    error = { status: 400, type: "not-unique-relationship", title: 'relationships exist' }
    render json: error, status: :bad_request
  end

  def create
    if @current_user.following?(params[:user_id])
      render json: { type: "duplicate-follow", title: "既にフォロー済みです", status: 400 }, status: :bad_request
      return
    end
    @current_user.relationships.create!(followed_id: params[:user_id], accepted: false)
    render json: { result: "ok" }
  end

  def unfollow
    @current_user.relationships.find_by!(followed_id: params[:user_id]).destroy
    render json: { result: "ok" }
  end

  def accept
    @relationships = @current_user.reverse_relationships.find_by!(follower_id: params[:user_id])
    @relationships.update!(accepted: true)
    render json: { result: "ok" }
  end

  def deny
    @current_user.reverse_relationships.find_by!(follower_id: params[:user_id]).destroy
    render json: { result: "ok" }
  end

  def block
    @current_user.accepted_reverse_relationships.find_by!(follower_id: params[:user_id]).destroy
    render json: { result: "ok" }
  end
end
