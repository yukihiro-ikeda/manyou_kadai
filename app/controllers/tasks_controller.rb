class TasksController < ApplicationController
  def index
    
    if params[:sort_expired]
      @tasks = Task.all.order(expired_at: "DESC")
      @tasks = @tasks.all.page(params[:page]).per(5)
    else
      @tasks = Task.all
      @tasks = @tasks.all.page(params[:page]).per(5)
    end

    if params[:sort_priority]
      @tasks = Task.all.order(priority: :asc)
      @tasks = @tasks.all.page(params[:page]).per(5)
    end

    if params[:task].present? 
      if params[:task][:name].present? && params[:task][:status].present?
      @tasks = Task.where(status: params[:task][:status]).where('name LIKE ?', "%#{params[:task][:name]}%")
      @tasks = @tasks.all.page(params[:page]).per(5)
    #params[:search]を#params[:task]に変更して機能した
      elsif params[:task][:name].present?
        @tasks = Task.where('name LIKE ?', "%#{params[:task][:name]}%")
        @tasks = @tasks.all.page(params[:page]).per(5)
      elsif params[:task][:status].present?
        @tasks = Task.where(status: params[:task][:status])
        @tasks = @tasks.all.page(params[:page]).per(5)
        # binding.irb
      end
    end
    
    if params[:status].present?
      @tasks = Task.where(status: params[:status])
      @tasks = @tasks.all.page(params[:page]).per(5)
      # binding.irb
    end
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
  def params_valid
    params.require(:task).permit(:name, :detail, :expired_at, :status, :priority )
  end
end
