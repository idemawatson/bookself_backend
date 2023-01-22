class User < ApplicationRecord
  has_many :books, dependent: :destroy

  def self.from_token_payload(payload)
    find_by(sub: payload['sub'])
  end
end
