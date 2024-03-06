class BooksController < ApplicationController
    def index
        @books = Book.all.order(created_at: :asc)
    end

    def create 
        @book = Book.create(params[:book])
        redirect_to books_path
    end
end
