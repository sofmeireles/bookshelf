require 'rails_helper'

RSpec.describe 'Books' do 

    describe 'POST #create' do 
        context 'when user is logged in' do
            include_context 'with logged user'

            context 'when params are valid' do 
                let(:book_params) do 
                    {
                        book: {
                            title: FFaker::Book.title,
                            genre: Book.genres.keys.sample,
                            description: FFaker::Book.description,
                            cover_url: FFaker::Book.cover    
                        }
                    }
                end

                it "creates a new book and redirects" do 
                    aggregate_failures do 
                        expect { post books_path(book_params) }.to change(Book, :count).by(1)
                        expect(response).to have_http_status(:found)
                        expect(response).to redirect_to(books_path)
                    end
                end
            end

            context 'when params are invalid' do 
                let(:invalid_params) do 
                    {
                        description: FFaker::Book.description
                    }
                end

                it "does not create a book" do 
                    aggregate_failures do 
                        expect { post books_path(invalid_params) }.to raise_error(ActionController::ParameterMissing)
                        .and change(Book, :count).by(0)
                    end
                end
            end

            context 'when params are missing' do 
                let(:missing_params) do 
                    {
                        book: {
                            title: FFaker::Book.title,
                            cover_url: FFaker::Book.cover    
                        }
                    }
                end

                it "does not create a book" do 
                    aggregate_failures do 
                        expect { post books_path(missing_params) }.not_to change(Book, :count)
                        expect(response).to have_http_status(:unprocessable_entity)
                    end
                end
            end
        end

        context 'when user is not logged in' do
            it 'redirect to login' do
                aggregate_failures do
                    expect { post books_path({}) }.not_to change(Book, :count)
                    expect(response).to have_http_status(:found)
                end
            end
        end
    end

    describe 'PATCH #update' do 
        let!(:book) { create(:book) }

        context 'when user is logged in' do
            include_context 'with logged user'

            context 'when params are valid' do 
                let(:book_params) do 
                    {
                        title: FFaker::Book.title,
                        genre: Book.genres.keys.sample
                    }
                end

                it "updates the book and redirects" do 
                    patch book_path(book), params: { book: book_params }

                    aggregate_failures do 
                        expect(response).to have_http_status(:found)
                        expect(response).to redirect_to(books_path)
                        expect(book.reload.title).to eq(book_params[:title])
                    end
                end
            end

            context 'when params are invalid' do 
                let(:invalid_params) do 
                    {
                        title: "Invalid Title",
                        description: nil
                    }
                end

                it "does not update the book" do 
                    patch book_path(book), params: { book: invalid_params }

                    aggregate_failures do 
                        expect(response).to have_http_status(:unprocessable_entity)
                        expect(book.reload.title).not_to eq(invalid_params[:title])
                    end
                end
            end
        end

        context 'when user is not logged in' do
            let(:book_params) do 
                {
                    title: FFaker::Book.title,
                    genre: Book.genres.keys.sample
                }
            end

            it 'redirect to login' do
                patch book_path(book), params: { book: book_params }

                aggregate_failures do
                    expect(response).to have_http_status(:found)
                    expect(book.reload.title).not_to eq(book_params[:title])
                end
            end
        end



    end


    describe '#POST reserve' do
        let(:book) { create(:book) }

        context 'when user is logged in' do
            include_context 'with logged user'

            context "when the params are valid" do
                it "creates a new reservation and redirects" do
                    aggregate_failures do
                        expect{ post reserve_book_path(book.id) }.to change(Reservation, :count).by(1)
                        expect(response).to redirect_to(books_path)
                        expect(response).to have_http_status(:found)
                        expect(flash[:notice]).to eq(I18n.t('notices.books.reserve_success', book_title: book.title)) 
                    end
                end
            end
        end

        context 'when user is not logged in' do
            it 'redirect to login' do
                aggregate_failures do
                    expect{ post reserve_book_path(book.id) }.not_to change(Reservation, :count)
                    expect(response).to have_http_status(:found)
                end
            end
        end
    end
end