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
    @book = @current_user.books.build(**params.permit(:book_id, :title, :image_url, :author, :page_count, :published_at, :description, :status))
    if @book.completed?
      @book.completed_at = Time.current.strftime('%Y-%m-%d')
    end

    if @book.invalid? && @book.errors.full_messages_for(:book_id)
      render json: { type: "duplicate-book", title: "既に本棚に追加済みです", status: 400 }, status: :bad_request
      return
    end

    @book.save!
    render json: { result: "ok" }
  end

  def update
    @book = @current_user.books.find(params[:id])
    @book.update!(**params.permit(:comment, :status, :completed_at))
    render json: { result: "ok" }
  end
end
