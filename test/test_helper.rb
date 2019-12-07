ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require "minitest/reporters"

Minitest::Reporters.use!
class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  # test環境でもApplicationヘルパーを使えるようにする
  include ApplicationHelper

  # テストユーザーがログイン中の場合にtrueを返す
  def is_logged_in?
    !session[:user_id].nil?
  end
  
  # テストユーザーとしてログインする
  def log_in_as(user)
    session[:user_id] = user.id
  end
end

class ActionDispatch::IntegrationTest

  # テストユーザーとしてログインする
  # TODO: 現状このmethodを使用すると error発生する。 methodの引数の設定方法が不明のため
  def log_in_as(user, u_password = 'password', u_remember_me = '1')
    # 統合テストではsessionを直接取り扱うことができないので、Sessionsリソースに対してpostを送信することで代用
    post login_path, params: { session: { email: user.email,
                                          password: u_password,
                                          remember_me: u_remember_me } }
  end
end