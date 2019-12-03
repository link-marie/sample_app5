class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  # debugger
  end

  # GET アクション
  def new
    @user = User.new
  end

  # ユーザー登録。POST アクション
  def create
    @user = User.new(user_params)
    if @user.save
      # Loginする
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def user_params
    # Strong Parameters: 指定された項目のみ設定可能
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
