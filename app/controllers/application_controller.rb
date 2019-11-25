class ApplicationController < ActionController::Base
  def hello
    render html: "I'm sample_app5!"
  end
end
