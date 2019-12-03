class ApplicationController < ActionController::Base
  # CSRF対策
  protect_from_forgery with: :exception
  # Session Helperを読み込む。どのコントローラでも使えるようにする   
  include SessionsHelper
  
  def hello
    render html: "I'm sample_app5!"
  end
end
