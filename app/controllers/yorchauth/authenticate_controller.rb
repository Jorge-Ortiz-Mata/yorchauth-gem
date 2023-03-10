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
      return if logged_in?

      flash[:notice] = 'Please, sign in to use this application'
      redirect_to login_path, status: :unauthorized
    end

    def deny_access
      return if session[:user_id].nil?

      flash[:notice] = 'You cannot access. Please sign out.'
      redirect_to root_path, status: :unauthorized
    end
  end
end
