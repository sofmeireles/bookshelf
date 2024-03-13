require 'rails_helper'

RSpec.describe 'Reservations' do 
  describe 'PATCH #update' do
    context 'when user is logged in' do
      include_context 'with logged user'

      context 'when reservation is active' do
        let(:reservation) { create(:reservation, user: user) }

        it "adds a returned date" do
          patch reservation_path(reservation.id)

          aggregate_failures do
            expect(reservation.reload.returned_on).not_to eq(nil)
            expect(response).to have_http_status(:ok)
          end
        end
      end

      context 'when reservation is not active' do
        let(:reservation) { create(:reservation, :returned, user: user) }

        it "raises an error" do
          patch reservation_path(reservation.id)

          aggregate_failures do
            expect(response).to have_http_status(:not_found)
          end
        end
      end
    end

  context 'when user is not logged in' do
    let(:reservation) { create(:reservation) }

    it 'redirects to login' do
      patch reservation_path(reservation.id)

      aggregate_failures do
        expect(response).to redirect_to(new_user_session_path)
        expect(response).to have_http_status(:found)
      end
    end

  end

  end
end