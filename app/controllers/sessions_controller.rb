class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # ユーザーログイン(helper method)
      log_in user
      # ユーザー情報のページにリダイレクト
      redirect_to user
     else
      # flash.now で、レンダリングが終わっているページで特別にフラッシュメッセージを表示
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
