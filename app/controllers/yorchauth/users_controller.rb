module Yorchauth
  class UsersController < AuthenticateController
    skip_before_action :authenticate_user, only: %i[new create confirm_account]
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
        UserMailer.with(user: @user).send_email_confirmation.deliver_later
        redirect_to login_path, notice: 'An email has been sent to your email account. Click on the link to validate your account.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @user.authenticate(params[:user][:old_password])
        if @user.update user_params
          redirect_to user_path(@user.token_id), notice: 'Account updated successfully'
        else
          render :edit, status: :unprocessable_entity
        end
      else
        redirect_to edit_user_path(@user.token_id), notice: 'Your current password is invalid'
      end
    end

    def destroy
      session[:user_id] = nil
      @user.destroy
      redirect_to login_path, notice: 'Your account has been deleted successfully'
    end

    def confirm_account
      if @user.present?
        if @user.confirmed?
          redirect_to login_path, notice: 'You have already confirmed your email account'
        else
          @user.update!(active: true)
          redirect_to login_path, notice: 'Your account has been successfully confirmed'
        end
      else
        redirect_to login_path, notice: 'You can not confirm this account because it is not linked to any user.'
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def set_user
      @user = User.find_by(token_id: params[:token_id])
      redirect_to root_path, notice: 'No user found' unless @user.present?
    end

    def authorize_user
      redirect_to root_path, notice: 'You are not authorized to perform this action' unless current_user.eql? @user
    end
  end
end
