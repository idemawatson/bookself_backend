class UserSerializer < ActiveModel::Serializer
  attributes %i[id name email]
  has_many :followings
  has_many :followers
end
