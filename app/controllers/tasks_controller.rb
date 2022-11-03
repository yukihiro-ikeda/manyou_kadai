class TasksController < ApplicationController
  def index
    if params[:sort_expired]
      @tasks = Task.all.order(expired_at: "DESC")    
    else
      @tasks = Task.all
    end
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

  private
  def params_valid
    params.require(:task).permit(:name, :detail, :expired_at)
  end
end
