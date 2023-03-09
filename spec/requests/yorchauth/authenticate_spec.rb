require 'rails_helper'

module Yorchauth
  RSpec.describe "AuthenticateController", type: :request do
    include Engine.routes.url_helpers
  end
end
