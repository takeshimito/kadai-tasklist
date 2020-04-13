class ApplicationController < ActionController::Base
  
  include SessionsHelper 
  
  private
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
 #ログインしていなければトップページ(tasks/index.html.erb)に戻す
end
