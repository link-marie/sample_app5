require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
  end

  test "profile display" do
    # プロフィール画面にアクセス
    get user_path(@user)
    assert_template 'users/show'
    # title存在チェックhelper methodを callsしてフルタイトルを得る
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    # ネスト文法: h1タグ内側の、gravatarクラス付きのimgタグがあるか
    assert_select 'h1>img.gravatar'
    # マイクロポストの投稿数が存在
    assert_match @user.microposts.count.to_s, response.body
    assert_select 'div.pagination'
    @user.microposts.paginate(page: 1).each do |micropost|
      # micropost内容が、HTML本文のなかに含まれるか
      assert_match micropost.content, response.body
    end
  end
end