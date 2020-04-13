class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  #ログインしていなければトップページへ飛ばす
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end
  #@users=Userの全データをid降順に並べたものをいれる

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks.order(id: :desc).page(params[:page])
  end
  #@user=user.idがuser/:idのuserを代入。つまり表示中のユーザー
  #@tasks=@user(表示中のuser)がもつtasksを代入

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザを登録しました'
      redirect_to @user
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
