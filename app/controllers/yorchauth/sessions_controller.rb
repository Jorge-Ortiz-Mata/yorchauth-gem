module Yorchauth
  class SessionsController < AuthenticateController
    skip_before_action :authenticate_user
    before_action :deny_access, only: %i[new create]
    before_action :set_user, only: %i[create]

    def new; end

    def create
      if @user&.authenticate(params[:session][:password])
        if @user.confirmed?
          session[:user_id] = @user.id
          redirect_to root_path
        else
          flash[:notice] = 'Your account has not been activated.'
          redirect_to login_path
        end
      else
        flash[:notice] = 'Incorrect email or password.'
        render :new, status: :unprocessable_entity
      end
    end

    def logout
      session[:user_id] = nil
      redirect_to login_path
    end

    private

    def set_user
      @user = User.find_by(email: params[:session][:email])
    end

    def session_params
      params.require(:session).permit(:email, :password)
    end
  end
end
