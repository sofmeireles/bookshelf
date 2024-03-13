require 'rails_helper'

RSpec.describe DeleteBook do
  let!(:book) { create(:book) }
  let(:delete_book) { described_class.new(book).perform }

  describe '#perform' do
    before { create(:reservation, book: book) }

    it "destroys the book and the associated reservations" do
        expect{ delete_book }.to change(Book, :count).by(-1)
                             .and change(Reservation, :count).by(-1)
        expect(delete_book.success?).to eq(true)
        expect{ book.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end