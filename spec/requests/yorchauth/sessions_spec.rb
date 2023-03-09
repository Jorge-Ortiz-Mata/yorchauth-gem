require 'rails_helper'

module Yorchauth
  RSpec.describe "/session", type: :request do
    include Engine.routes.url_helpers

    # This should return the minimal set of attributes required to create a valid
    # User. As you add validations to User, be sure to
    # adjust the attributes here as well.
    let(:user_active) { create :yorchauth_user, :with_email, :with_long_password, :as_active }
    let(:user_deactive) { create :yorchauth_user, :with_email, :with_long_password }

    let(:valid_params) { { email: 'user@email.com', password: '123password' } }
    let(:invalid_params) { { email: 'invaliduser@email.com', password: '92hfbnj' } }

    describe "GET /login" do
      it "returns http success when visiting login page" do
        get login_path
        expect(response).to have_http_status(:success)
      end
    end

    describe 'POST /login' do
      it "returns http unprocessable entity when params are correct" do
        user_active.reload
        post login_path, params: { session: valid_params }

        expect(response).to have_http_status(:success)
      end

      it "returns http unprocessable entity when account is not confirmed" do
        user_deactive.reload
        post login_path, params: { session: valid_params }

        expect(user_deactive.active).to be_falsey
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns http unprocessable entity when account is not confirmed" do
        user_deactive.reload
        post login_path, params: { session: invalid_params }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    describe 'DELETE /logout' do
      it "returns http success when closing a session" do
        user_active.reload
        post login_path, params: { session: valid_params }

        expect(response).to have_http_status(:success)

        delete logout_path
        expect(response).to have_http_status(:success)
      end
    end
  end
end
