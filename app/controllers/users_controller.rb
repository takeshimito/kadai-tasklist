class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザを登録しました'
      redirect_to root_url
    else
      flash[:success] = 'ユーザ登録に失敗しました'
      render :new
    end
  end
  #@user=User.new(user_params)はparams[:task]でも良いがセキュリティとしてストロングパラメーターしよう


  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  #セキュリティーuserモデルのデータの中のカラムであるということを示す

end
