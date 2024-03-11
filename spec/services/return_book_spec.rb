require 'rails_helper'

RSpec.describe ReturnBook do
  let!(:admin_user) { create(:user, :is_admin) }
  let(:return_book) { described_class.new(reservation).perform }

  describe '#perform' do
    context 'on an active reservation' do 
      let(:reservation) { create(:reservation) }

      it "must add the returned date" do
        return_book

        aggregate_failures do 
          expect(reservation.reload.returned_on).to eq(Date.today)
          expect(return_book.success?).to eq(true)
          expect(SendReturnedBookEmailJob).to have_enqueued_sidekiq_job(reservation.user_id, admin_user.id, reservation.book_id)
        end
      end
    end

    context 'on a closed reservation' do 
      let!(:reservation) { create(:reservation, :returned) }

      it "does not update the returned on date" do
        return_book

        aggregate_failures do 
          expect(reservation.reload.returned_on).not_to eq(Date.today)
          expect(return_book.success?).to eq(false)
          expect(return_book.errors.first).to eq("Returned on cannot be revised once set.")
          expect(SendReturnedBookEmailJob).not_to have_enqueued_sidekiq_job(any_args)
        end
      end
    end
  end
  
end