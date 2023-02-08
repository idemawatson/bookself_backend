class User < ApplicationRecord
  has_many :books, dependent: :destroy

  has_many :relationships, -> { where(accepted: true) }, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, -> { where(accepted: true) }, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  def self.from_token_payload(payload)
    find_by(sub: payload['sub'])
  end

  def following?(user)
    followings.include?(user)
  end
end
