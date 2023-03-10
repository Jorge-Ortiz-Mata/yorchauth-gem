require 'rails_helper'

module Yorchauth
  RSpec.describe "AuthenticateController", type: :request do
    include Engine.routes.url_helpers

    # This should return the minimal set of attributes required to create a valid
    # authentication. As you add validations to User, be sure to
    # adjust the attributes here as well.
    let(:user_active) { create :yorchauth_user, :with_email, :with_long_password, :as_active }
    let(:valid_params) { { email: 'user@email.com', password: '123password' } }

    context 'as the same user' do
      describe "GET /" do
        it 'can not access to the root_path' do
          get root_path

          expect(response).to_not have_http_status(200)
          expect(response).to have_http_status(401)
        end

        it 'can access to the root_path' do
          user_active.reload
          post login_path, params: { session: valid_params }
          get root_path

          expect(response).to_not have_http_status(401)
          expect(response).to have_http_status(200)
        end
      end

      describe "GET /signup" do
        it 'can not access to the signup path once a user is logged in' do
          user_active.reload
          post login_path, params: { session: valid_params }
          get signup_path

          expect(response).to have_http_status(401)
        end
      end

      describe "GET /login" do
        it 'can not access to the login path once a user is logged in' do
          user_active.reload
          post login_path, params: { session: valid_params }
          get login_path

          expect(response).to have_http_status(401)
        end
      end
    end
  end
end
