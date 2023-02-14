class ProfileSerializer < UserSerializer
  has_many :followings
  has_many :followers
  has_many :request_followers
  attribute :book_count
  attribute :all_pages

  def book_count
    object.books.completed.count
  end

  def all_pages
    object.books.completed.sum(:page_count)
  end

  attributes :rest_experience do
    object.rest_experience
  end
  attributes :progress do
    object.progress
  end
end
