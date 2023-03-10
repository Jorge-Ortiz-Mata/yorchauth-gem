module Yorchauth
  class UsersController < AuthenticateController
    skip_before_action :authenticate_user, only: %i[new create confirm_account]
    before_action :deny_access, only: %i[new create]
    before_action :set_user, only: %i[edit update show destroy confirm_account]
    before_action :authorize_user, only: %i[edit update destroy]

    def new
      @user = User.new
    end

    def edit; end

    def show; end

    def create
      @user = User.new user_params

      if @user.save
        Yorchauth::UserMailer.with(user: @user).send_email_confirmation.deliver_later
        flash[:notice] = 'An email has been sent to your email account. Click on the link to validate your account.'
        redirect_to login_path, status: :ok
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @user.authenticate(params[:user][:old_password])
        if @user.update user_params
          flash[:notice] = 'Account updated successfully'
          redirect_to user_path(@user.token_id), status: :ok
        else
          render :edit, status: :unprocessable_entity
        end
      else
        flash[:notice] = 'Your current password is invalid'
        redirect_to edit_user_path(@user.token_id), status: :unprocessable_entity
      end
    end

    def destroy
      session[:user_id] = nil
      @user.destroy

      flash[:notice] = 'Your account has been deleted successfully'
      redirect_to login_path, status: :ok
    end

    def confirm_account
      if @user.present?
        if @user.confirmed?
          flash[:notice] = 'You have already confirmed your email account'
        else
          @user.update!(active: true)
          flash[:notice] = 'Your account has been successfully confirmed'
        end
      else
        flash[:notice] = 'You can not confirm this account because it is not linked to any user.'
      end
      redirect_to login_path, status: :ok
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def set_user
      @user = User.find_by(token_id: params[:token_id])
      return @user if @user.present?

      flash[:notice] = 'There is not user with this token'
      redirect_to root_path, status: :not_found
    end

    def authorize_user
      return if current_user.eql? @user

      flash[:notice] = "You are not authorized to perform this action"
      redirect_to root_path, status: :unauthorized
    end
  end
end
