class Api::V1::BooksController < SecuredController
  def index
    @books = @current_user.books.order(completed_at: :asc).page(params.fetch(:page, 1)).per(12)
    total_pages = @current_user.books.page.per(12).total_pages
    render json: @books, each_serializer: BookSerializer, meta: { total_pages: }, adapter: :json
  end

  def show
    book = Book.find(params[:id])
    render json: book, each_serializer: BookSerializer
  end

  def create
    book = @current_user.books.create(**params.permit(:title, :image_url, :author, :page_count, :published_at, :description), book_id: params[:id])
    if book.valid?
      render json: { result: "ok" }
    elsif book.errors.full_messages_for(:book_id)
      render json: { type: "duplicate-book", title: "既に本棚に追加済みです" }, status: :bad_request
    else
      render json: { type: "invalid-request" }, status: :bad_request
    end
  end

  def update
    @book = @current_user.books.find(params[:id])
    @book.update(**params.permit(:comment, :status, :completed_at))
  end
end
