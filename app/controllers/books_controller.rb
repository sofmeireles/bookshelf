class BooksController < ApplicationController
    before_action :set_book, only: %i[show edit update]

    def index
        @books = Book.all.order(created_at: :desc)
    end

    def new
        @book = Book.new
    end

    def create
        result = CreateBook.new(book_params).perform
        
        if result.success?
          redirect_to(books_path, notice: I18n.t('notices.books.create_success', book_title: result.book.title))
        else
          flash.now[:alert] = result.errors
          render :new, status: :unprocessable_entity
        end
    end

    def show 
    end

    def edit
    end

    def update 
        result = UpdateBook.new(@book, book_params).perform

        if result.success?
            redirect_to(books_path, notice: I18n.t('notices.books.update_success', book_title: result.book.title))
        else
            flash.now[:alert] = result.errors
            render :edit, status: :unprocessable_entity
        end
    end
      
    private

    def book_params
        params.require(:book).permit(:title, :genre, :description, :cover_url)
    end

    def set_book
        @book = Book.find(params[:id])
    end
end
