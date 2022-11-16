class Admin::UsersController < ApplicationController
  before_action :admin_user
  skip_before_action :admin_user, only: [:update]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def index
    @users = User.all.includes(:tasks)
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "ユーザを編集しました"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "ユーザを削除しました"
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def admin_user
    unless current_user.admin == true
      flash[:danger] = "管理者以外アクセスできません"
      redirect_to tasks_path 
    end
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end