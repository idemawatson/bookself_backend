class Api::V1::BooksController < SecuredController
  def index
    books = @current_user.books.page(params.fetch(:page, 1)).per(12)
    total_pages = @current_user.books.page.per(12).total_pages
    render json: { books:, total_pages: }
  end

  def show
    book = Book.find(params[:id])
    render json: book
  end

  def create
    book = @current_user.books.create(book_id: params[:id], title: params[:title], image_url: params[:imageUrl], author: params[:author],
                                      page_count: params[:pageCount], publishedAt: params[:publishedDate], description: params[:description])
    if book.valid?
      render json: { result: "ok" }
    elsif book.errors.full_messages_for(:book_id)
      render json: { type: "duplicate-book", title: "既に本棚に追加済みです" }, status: :bad_request
    else
      render json: { type: "invalid-request" }, status: :bad_request
    end
  end
end
