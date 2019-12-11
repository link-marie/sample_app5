class AccountActivationsController < ApplicationController
  
  # アカウントを有効化する
  def edit
    user = User.find_by(email: params[:email])
    # 必ず一度も有効化されていいないかチェックする
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "Account activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
