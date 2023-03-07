module Yorchauth
  class AuthenticateController < ApplicationController
    before_action :authenticate_user
    helper_method :logged_in?, :current_user

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def logged_in?
      !!current_user
    end

    private

    def authenticate_user
      redirect_to login_path, notice: 'Please, sign in to use this application' unless logged_in?
    end

    def deny_access
      redirect_to root_path unless session[:user_id].nil?
    end
  end
end
