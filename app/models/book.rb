class Book < ApplicationRecord
  belongs_to :user
  enum :status, { want: 0, tsundoku: 1, reading: 2, completed: 3 }
  validates :book_id, uniqueness: { scope: :user_id, message: "既に本棚に登録済みです。" }
  validates :title, presence: true
  validates :comment, length: { maximum: 1000 }

  validate :valid_completed_at

  private

    def valid_completed_at
      return if completed? == !completed_at.nil?

      errors.add(:completed_at, "status or completed_at is invalid.")
    end
end
