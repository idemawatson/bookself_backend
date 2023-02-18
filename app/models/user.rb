class User < ApplicationRecord
  has_many :books, dependent: :destroy

  has_many :relationships, -> { where(accepted: true) }, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

  has_many :accepted_reverse_relationships, -> { where(accepted: true) }, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :accepted_reverse_relationships, source: :follower

  has_many :reverse_relationships, -> { where(accepted: false) }, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :request_followers, through: :reverse_relationships, source: :follower

  validates :name, length: { maximum: 30 }

  LEVEL_UP_BASE_EXPERIENCE = 10
  LEVEL_UP_EXPERIENCE_MULTIPLIER = 50

  def self.from_token_payload(payload)
    find_by(sub: payload['sub'])
  end

  def following?(user_id)
    followings.exists?(id: user_id)
  end

  def add_experience!(points)
    self.experience += points
    while self.experience >= next_level_experience
      self.experience -= next_level_experience
      self.level += 1
    end
    save!
  end

  def next_level_experience
    calc_experience(self.level)
  end

  def pre_level_experiense
    self.level == 1 ? 0 : calc_experience(self.level - 1)
  end

  def calc_experience(level)
    (LEVEL_UP_BASE_EXPERIENCE * level + LEVEL_UP_EXPERIENCE_MULTIPLIER * 1.05**(level - 1)).floor
  end

  def rest_experience
    logger.debug("next: #{next_level_experience}, self: #{self.experience}, prev: #{pre_level_experiense}")
    next_level_experience - self.experience
  end

  def progress
    rest_experience.fdiv(next_level_experience).floor(2) * 100
  end
end
