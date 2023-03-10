module Yorchauth
  class PagesController < AuthenticateController
    before_action :authenticate_user

    def index; end
  end
end
