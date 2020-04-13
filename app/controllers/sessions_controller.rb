class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      flash[:seccess] = 'ログインに成功しました'
      redirect_to root_url
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end
  #params[:session][:---]で送られてきた値を二つのパラメーターに代入する

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました'
    redirect_to root_url
  end
  #session[:user_id]をnilにすることでログアウト
  
  private
  
  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      session[:user_id] = @user.id
      return true
    else
      return false
    end
  end
  #emailとpasswordがあっていれば
  # session[:user_id] = @user.id が代入されればログイン成功
end
