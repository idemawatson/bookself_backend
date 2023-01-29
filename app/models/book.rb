class Book < ApplicationRecord
  belongs_to :user
  validates :book_id, uniqueness: { scope: :user_id, message: "既に本棚に登録済みです。" }
end
