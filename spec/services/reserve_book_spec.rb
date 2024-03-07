require 'rails_helper'

RSpec.describe ReserveBook do
  let(:book) { create(:book) }
  let(:user) { create(:user) }
  let!(:admin_user) { create(:user, :is_admin) }
  let(:reserve_book) { described_class.new(book, user.id).perform }

  describe '#perform' do
    context 'when book and user meet reservation criteria' do 
      it "must create a new reservation" do
        aggregate_failures do 
          expect{ reserve_book }.to change(Reservation, :count).by(1)
          expect(reserve_book.success?).to eq(true)
          expect(SendNewReservationEmailJob).to have_enqueued_sidekiq_job(user.id, admin_user.id, book.id)
        end
      end
    end

    context 'when the user has a prior reservation' do 
      before { create(:reservation, user: user) }
      it "raises a double reservation error " do
        aggregate_failures do 
          expect{ reserve_book }.not_to change(Reservation, :count)
          expect(reserve_book.success?).to eq(false)
          expect(*reserve_book.errors).to eq("The user cannot reserve multiple books.")
          expect(SendNewReservationEmailJob).not_to have_enqueued_sidekiq_job(any_args)
        end
      end
    end

    context 'when a book is already reserved' do 
      before { 
        create(:reservation, book: book)
        book.reload
      }

      it "raises a double reservation error " do
        aggregate_failures do 
          expect{ reserve_book }.not_to change(Reservation, :count)
          expect(reserve_book.success?).to eq(false)
          expect(*reserve_book.errors).to eq("The book cannot be double reserved.")
          expect(SendNewReservationEmailJob).not_to have_enqueued_sidekiq_job(any_args)
        end
      end
    end
  end
  
end