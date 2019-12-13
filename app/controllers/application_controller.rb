class ApplicationController < ActionController::Base
  # CSRF対策
  protect_from_forgery with: :exception
  # Session Helperを読み込む。どのコントローラでも使えるようにする   
  include SessionsHelper
  
  def hello
    render html: "I'm sample_app5!"
  end
  
  private

    # ユーザーのログインを確認する
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
