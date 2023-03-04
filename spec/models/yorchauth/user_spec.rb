require 'rails_helper'

module Yorchauth
  RSpec.describe User, type: :model do
    let(:user1) { build :yorchauth_user, :with_email, :with_long_password }
    let(:user2) { build :yorchauth_user, :with_email, :with_short_password }
    let(:user3) { build :yorchauth_user }

    describe 'validations' do
      it { should have_secure_password }
      it { should validate_uniqueness_of(:email) }
      it { should validate_presence_of(:email) }
      it { should validate_presence_of(:password) }
      it { should validate_length_of(:password) }
      it { should validate_presence_of(:password_confirmation) }
      it { should validate_length_of(:password_confirmation) }
    end

    describe 'instance' do
      it 'should be valid' do
        expect(user1).to be_valid
      end

      it 'should not be valid' do
        expect(user2).to_not be_valid
        expect(user3).to_not be_valid
      end
    end
  end
end
