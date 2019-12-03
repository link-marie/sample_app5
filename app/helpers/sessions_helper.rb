module SessionsHelper
  # login ユーザーを記憶。 cookieで管理
  def log_in(user)
    session[:user_id] = user.id
  end
  
  # 現在ログイン中のユーザーを返す (いる場合)
  def current_user
    if session[:user_id]
      # 結果をインスタンス変数に保存
      # ||=で 変数の値がnilなら変数に代入するが、nilでなければ代入しない
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
    # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end
  
  # 現在のユーザーをログアウトする
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
