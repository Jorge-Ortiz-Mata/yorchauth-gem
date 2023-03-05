class UsersController < AuthenticateController
  skip_before_action :authenticate_user, only: %i[new create]
  before_action :set_user, only: %i[edit update show destroy]
  before_action :authorize_user, only: %i[edit update destroy]

  def new
    @user = User.new
  end

  def edit; end

  def show; end

  def create
    @user = User.new user_params

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.authenticate(params[:user][:old_password])
      if @user.update user_params
        redirect_to user_path(@user), notice: 'Account updated successfully'
      else
        render :new, status: :unprocessable_entity
      end
    else
      redirect_to edit_user_path(@user), notice: 'Your current password is invalid'
    end
  end

  def destroy
    session[:user_id] = nil
    @user.destroy
    redirect_to login_path, notice: 'Your account has been deleted successfully'
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user
    redirect_to root_path, notice: 'You are not authorized to perform this action' unless current_user.eql? @user
  end
end
