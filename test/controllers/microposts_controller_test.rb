require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @micropost = microposts(:orange)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Micropost.count' do
      # micropostの投稿を試みる(現在loginしていない)
      post microposts_path, params: { micropost: { content: "Lorem ipsum" } }
    end
    # loginURL へ リダイレクト
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Micropost.count' do
      delete micropost_path(@micropost)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong micropost" do
    log_in_as(users(:michael))
    # login中以外のuserによる micropost生成
    micropost = microposts(:ants)
    # micropostの数は変化しない
    assert_no_difference 'Micropost.count' do
      # 自分以外の micropostの削除
      delete micropost_path(micropost)
    end
    # redirect
    assert_redirected_to root_url
  end
end