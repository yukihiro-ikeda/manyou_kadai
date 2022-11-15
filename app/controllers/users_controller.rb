class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :set_user, only: [:show]
  before_action :current_user_cannot, only: [:new]
  before_action :current_user_cannot_others_show, only: [:show]

  def new
    @user = User.new 
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def current_user_cannot
    redirect_to tasks_path if logged_in?
  end

  def current_user_cannot_others_show
    redirect_to tasks_path unless current_user.id == @user.id
    # binding.irb
  end
end
