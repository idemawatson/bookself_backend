class Book < ApplicationRecord
  belongs_to :user
  enum :status, { want: 0, tsundoku: 1, reading: 2, completed: 3 }
  validates :book_id, uniqueness: { scope: :user_id, message: "既に本棚に登録済みです。" }
end
