class Api::V1::BooksController < SecuredController
  def index
    books = @current_user.books.page(params.fetch(:page, 1)).per(12)
    total_pages = @current_user.books.page.per(12).total_pages
    render json: { books: books, total_pages: total_pages }
  end

  def show
    book = Book.find(params[:id])
    render json: book
  end
end
