class UserSerializer < ActiveModel::Serializer
  attributes %i[id name email level experience]
  attribute :following, if: :current_user?

  def current_user?
    !scope.nil? && scope[:current_user]
  end

  def following
    scope[:current_user].following?(object.id)
  end
end
