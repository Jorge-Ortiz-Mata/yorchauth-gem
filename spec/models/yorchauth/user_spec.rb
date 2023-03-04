require 'rails_helper'

module Yorchauth
  RSpec.describe User, type: :model do
    let(:valid_user) { build :yorchauth_user, :with_email, :with_password }
    let(:invalid_user) { build :yorchauth_user }

    it { should validate_presence_of(:email) }

    describe 'instance' do
      it 'should be valid' do
        expect(valid_user).to be_valid
      end

      it 'should not be valid' do
        expect(invalid_user).to_not be_valid
      end
    end
  end
end
