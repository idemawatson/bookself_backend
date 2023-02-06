class Api::V1::BooksController < SecuredController
  def index
    status = params.fetch(:status, -1).to_i
    @books = @current_user.books
                          .yield_self { |scope| status < 0 ? scope : scope.where(status:) }
                          .order("completed_at DESC NULLS LAST")
                          .order(updated_at: :desc)
                          .page(params.fetch(:page, 1))
                          .per(12)
    total_page = @books.total_pages.yield_self { |pages| pages === 0 ? 1 : pages }
    render json: @books, each_serializer: BookSerializer
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
