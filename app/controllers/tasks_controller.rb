class TasksController < ApplicationController
  before_action :require_user_logged_in
  #ログインしていなければトップページへ戻る
  before_action :correct_user, only: [:destroy, :update]
  #ログイン中のユーザーの自分のタスク以外ならトップページ戻る
  
  def index
    if logged_in?
      #@tasks = current_user.tasks.order(id: :desc).page(params[:page])
      @tasks = Task.order(id: :desc).page(params[:page])
    end
  end
  #ログインしていれば、@tasksインスタンスを生成
  
  def show
    #current_user = User.find_by(id: session[:user_id]) いらない
    @task = Task.find(params[:id])
  end
  #current_user＝ログイン中のユーザ
  #@task＝task全件の中から選択したtask
  
  def new
    @task = current_user.tasks.build
  end
  #@task= Task.new(user: user)のこと
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'Taskが正常に投稿されました'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'Taskが投稿されませんでした'
      render :new
    end
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  #取り扱い中のタスクのインスタンス　updateにcorrect_userを適応しているからOK
  
  def update
    if @task.update(task_params)
      flash[:success] = 'Taskは正常に更新されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'Taskは更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    flash[:success] = 'Taskは正常に削除されました'
    redirect_to root_url
  end
  #correct_userの中に@taskインスタンスがあるため@task=は省略
  
  private 
  
  
  def correct_user
    #@task = current_user.tasks.find_by(id: params[:id])
    @task = current_user.tasks.find(params[:id])
    unless @task
      redirect_to root_path
    end
  end
  #@task=表示中（取り扱い中）のtask.idがログインユーザのtasksから検索
  #もし違えばトップページに戻る（タスク一覧）
  
  def task_params
   params.require(:task).permit(:content, :status)
  end
  #taskモデルの中のそれぞれのカラムを使用する
end
