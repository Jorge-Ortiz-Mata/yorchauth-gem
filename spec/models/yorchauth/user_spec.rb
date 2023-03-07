require 'rails_helper'

module Yorchauth
  RSpec.describe User, type: :model do
    let(:user) { create :yorchauth_user, :with_email, :with_long_password, :as_active }

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
        expect(user).to be_valid
      end
    end
  end
end
