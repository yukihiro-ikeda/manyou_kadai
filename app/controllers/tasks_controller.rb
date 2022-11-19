class TasksController < ApplicationController
  # skip_before_action :login_required, only: [:new, :create]
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :check_user, only: %i[show edit update destroy]

  def index
    # @tasks = current_user.tasks.page(params[:page]).per(5)
    # @tasks = current_user.tasks.order(created_at: "DESC").page(params[:page]).per(5)
    @tasks = current_user.tasks

    if params[:sort_expired]
      @tasks = @tasks.order(expired_at: "DESC")
      # binding.irb
      # @tasks = current_user.tasks.all.includes(:user).order(expired_at: "DESC")
      # binding.irb
      # @tasks = @tasks.all.page(params[:page]).per(5)
    # else
    #   # p "ここを通過"
    #   @tasks = Task.all
    #   @tasks = @tasks.all.page(params[:page]).per(5)
    end

    if params[:sort_priority]
      @tasks = @tasks.order(priority: :asc)
      # @tasks = @tasks.all.page(params[:page]).per(5)
    end

    if params[:task].present? 
      if params[:task][:name].present? && params[:task][:status].present?
        # @tasks = current_user.tasks.all.includes(:user).order(expired_at: "DESC")
        @tasks = @tasks.task_name(params[:task][:name]).status_name(params[:task][:status])
        # @tasks = @tasks.all.page(params[:page]).per(5)
      elsif params[:task][:name].present?
        # @tasks = current_user.tasks.all.includes(:user).order(expired_at: "DESC")
        @tasks = @tasks.task_name(params[:task][:name])
        # @tasks = @tasks.all.page(params[:page]).per(5)
      elsif params[:task][:status].present?
        # current_user.tasks.all.includes(:user).order(expired_at: "DESC")
        @tasks = @tasks.status_name(params[:task][:status])
        # @tasks = @tasks.all.page(params[:page]).per(5)
        # binding.irb
      elsif params[:label_id].present?
        @tasks = Label.find(params[:label_id]).tasks.page(params[:page]).per(5)
      end
      # @tasks = @tasks.page(params[:page]).per(5)
    end
    @tasks = @tasks.order(created_at: "DESC").page(params[:page]).per(5)
    # if params[:status].present?
    #   @tasks = Task.status_name(params[:status][:name])
    #   @tasks = @tasks.all.page(params[:page]).per(5)
    #   # binding.irb
    # end
    # @tasks = @tasks.where('title LIKE ?', "%#{params[:search]}%") if params[:search].present?
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(params_valid)
    @task.user_id = current_user.id
    if @task.save
      redirect_to tasks_path, notice: "タスクを登録しました"
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id]) 
    if @task.update(params_valid)  
      redirect_to tasks_path, notice: "タスクを更新しました"
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました"
  end

  # def search
  #   @tasks = current_user.tasks.looks(params[:status], params[:name_cont]).page(params[:page])
  # end

  private
  
  def set_task
    @task = Task.find(params[:id])
  end

  def params_valid
    params.require(:task).permit(:name, :detail, :expired_at, :status, :priority, { label_ids: [] } )
  end

  def check_user
    @task = Task.find(params[:id])
    if current_user.id != @task.user_id
      redirect_to tasks_path, notice: 'アクセスできません'
    end
  end
  
end
