class Api::V1::BooksController < SecuredController
  def index
    status = params.fetch(:status, -1).to_i
    @books = @current_user.books
                          .yield_self { |scope| status.negative? ? scope : scope.where(status:) }
                          .order("completed_at DESC NULLS LAST")
                          .order(updated_at: :desc)
                          .page(params.fetch(:page, 1))
                          .per(12)
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

    ApplicationRecord.transaction do
      @book.save!
      if @book.completed?
        @current_user.add_experience!(params[:page_count])
      end
    end

    render json: { result: "ok" }
  end

  def update
    @book = @current_user.books.find(params[:id])

    ApplicationRecord.transaction do
      if @book.status_before_type_cast != params[:status]
        if params[:status] == Book.statuses[:completed]
          @current_user.add_experience!(@book.page_count.to_i)
        elsif @book.completed?
          @current_user.add_experience!(-1 * @book.page_count.to_i)
        end
      end
      @book.update!(**params.permit(:comment, :status, :completed_at))
    end

    render json: { result: "ok" }
  end
end
