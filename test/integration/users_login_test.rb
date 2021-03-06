require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    # fixtureデータを使用している
    # @user = users(:michael)
    @user = users(:aaa)
  end
  
  test "login with invalid information" do
    # ログイン用のパスを開く
    get login_path
    # 新しいセッションのフォームが正しく表示されたことを確認
    assert_template 'sessions/new'
    # わざと無効なparamsハッシュを使ってセッション用パスにPOST
    post login_path, params: { session: { email: "", password: "" } }
    # 新しいセッションのフォームが再度表示
    assert_template 'sessions/new'
    # フラッシュメッセージが追加されることを確認
    assert_not flash.empty?
    # Homeページに移動
    get root_path
    # フラッシュメッセージが消えていることを確認
    assert flash.empty?
  end
  
  test "login with valid information followed by logout" do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    # TestHelper methodが使える
    assert is_logged_in?
    assert_redirected_to @user
    # リダイレクト先が正しいかチェック
    follow_redirect!
    assert_template 'users/show'
    # リンク先に移動。対照リンクがないことをチェック
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)

###### Logoutテスト
    # DELETEリクエスト(ルーティングに定義されている)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    
    # 2番目のウィンドウでログアウトをクリックするユーザーをシミュレートする
    # current_userがない場合はエラーとなる
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
  
 test "login with remembering" do
  # log_in_as(@user, password: 'password1', remember_me: '1')
    post login_path, params: { session: { email: 'aaa@sample.com',
                                          password: 'password',
                                          remember_me: '1' } }
  
    assert_not_nil cookies['remember_token']
  # assert_equal cookies['remember_token'], assigns(:user).remember_token

  end

  test "login without remembering" do
    # クッキーを保存してログイン
    post login_path, params: { session: { email: 'aaa@sample.com',
                                          password: 'password',
                                          remember_me: '1' } }
  
    # クッキーを削除して
    delete logout_path
    # ログイン
    post login_path, params: { session: { email: 'aaa@sample.com',
                                          password: 'password',
                                          remember_me: '0' } }
  
    assert_empty cookies['remember_token']
  end

end