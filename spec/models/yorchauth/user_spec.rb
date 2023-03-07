require 'rails_helper'

module Yorchauth
  RSpec.describe User, type: :model do
    let(:valid_user) { build :yorchauth_user, :with_email, :with_long_password, :as_active }
    let(:invalid_user) { build :yorchauth_user, :with_email, :with_short_password }

    describe 'validations' do
      it { should have_secure_password }
      it { should have_secure_token(:token_id).ignoring_check_for_db_index }
      it { should validate_length_of(:token_id) }
      it { should validate_presence_of(:email) }
      it { should validate_uniqueness_of(:email) }
      it { should validate_presence_of(:password) }
      it { should validate_length_of(:password) }
      it { should validate_presence_of(:password_confirmation) }
      it { should validate_length_of(:password_confirmation) }
    end

    describe 'instance' do
      it 'should be valid' do
        expect(valid_user).to be_valid
      end

      it 'should not be valid' do
        expect(invalid_user).to_not be_valid
      end
    end

    describe 'custom methods' do
      it 'should return true when user account is active' do
        expect(valid_user.confirmed?).to be_truthy
      end
    end
  end
end
