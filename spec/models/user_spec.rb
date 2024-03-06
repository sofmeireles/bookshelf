require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) {create(:user)}

  describe 'validations' do
    it { expect(user).to be_valid}
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

  end

  describe 'associations' do
    it {is_expected.to have_many(:reservations)}
    it {is_expected.to have_one(:active_reservation)}
    it {is_expected.to have_one(:active_reading)}
  end

  describe '#actively_reading' do
    context 'when user is actively reading' do
      before do
        create(:reservation, user: user)
      end

      it "must be true" do
        expect(user.reload.actively_reading?).to eq(true)
      end
    end

    context "when user isn't actively reading" do
      it "must be false" do
        expect(user.reload.actively_reading?).to eq(false)
      end
    end
  end

  describe '.admin_users' do
    let(:admin) {create(:user, is_admin: true)}
    let(:non_admin) {create(:user)}

    it "includes users with admin flag" do
      expect(User.admin_users).to include(admin)
    end

    it "excludes users without admin flag" do
      expect(User.admin_users).not_to include(non_admin)
    end
  end

end
