class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)

    if @user && @user.authenticate(params[:session][:password])

      if @user.activated?
        # ユーザーログイン(helper method)
        log_in @user
        # checkboxを確認: checked: 記憶 , unchecked: 消去
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        # クエストされたURLが存在する場合はそこにリダイレクトし、ない場合は何らかのデフォルトのURLにリダイレクト
        redirect_back_or @user
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
     else
      # flash.now で、レンダリングが終わっているページで特別にフラッシュメッセージを表示
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    # LogInしている場合のみ Logoutする
    log_out if logged_in?
    redirect_to root_url
  end
end
