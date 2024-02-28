require 'rails_helper'

RSpec.describe Reservation, type: :model do
  subject(:reservation) {create(:reservation)}

  describe 'associations' do
    it {is_expected.to belong_to(:book)}
    it {is_expected.to belong_to(:user)}
  end

  describe 'validations' do
    it { expect(reservation).to be_valid}
    
    context "when there is a try to reserve a book with an existing reservation" do
      let(:book) {create(:book)}

      before do
        create(:reservation, book: book)
      end

      it "must raise a validation error" do
        book.reload
        expect{create(:reservation, book: book)}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end


    context "when a user with an active reservation tries to reserve another book" do
      let(:user) {build(:user)}

      before do
        create(:reservation, user: user)
      end

      it "must raise a validation error" do
        user.reload
        expect{create(:reservation, user: user)}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "when there's a try to return a book with a past date" do
      it "must raise a validation error" do
        expect{create(:reservation, returned_on: Date.yesterday)}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "when there's a try to update the returned date" do
      let(:reservation) {create(:reservation, :returned)}

      it "must raise a validation error" do
        expect{ reservation.update!(returned_on: Date.tomorrow)}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end 
  end

  describe "scopes" do
    let(:active_reservation) { create(:reservation) }
    let(:non_active_reservation) { create(:reservation, :returned )}
    
    context '.active' do
      it "includes active reservations" do
          expect(Reservation.active).to include(active_reservation)
      end
  
      it "excludes inactive reservations" do
          expect(Reservation.active).not_to include(non_active_reservation)
        
      end
    end

    context '.inactive' do
      it "includes active inactive" do
        expect(Reservation.inactive).to include(non_active_reservation)
      end
  
      it "excludes active reservations" do
          expect(Reservation.inactive).not_to include(active_reservation)

      end
    end

  end 
end
