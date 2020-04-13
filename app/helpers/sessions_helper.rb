module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  #user.id = session[:user_id]のユーザー（ログイン中の）をインスタンスとして定義
  #ログインしているユーザーのインスタンス, ログインしていなければnilを返す

  def logged_in?
    !!current_user
  end
  #ログイン指定たらtrue, していなければfalse
  
end
