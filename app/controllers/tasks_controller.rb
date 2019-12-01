class TasksController < ApplicationController
  before_action :find_task, except: %i[index create]

  def index
    load_index_data
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      flash.now[:success] = "New Task was Successfully created"
      redirect_to action: "index"
    else
      flash.now[:error] = "New Task could not be created"
      redirect_to action: "new"
    end
  end

  def update
    @task = find_task

    begin
      if @task.update(task_params)
        flash.now[:success] = "#{@task.title} task was Successfully updated and now is #{@task.status}"
        redirect_to action: "index"
      else
        raise(ActiveRecord::RecordInvalid, @user)
      end
    rescue
      flash.now[:error] = "Task could not be updated"
      redirect_to action: "index"
    end
  end

  def show
    @category = Category.new
    @comment  = Comment.new
    @task     = find_task

    respond_to do |format|
      format.js
    end
  end

  def destroy
    puts "destroying the action now"
    begin
      @task = Task.find(params[:id])
      @task.destroy

      redirect_to action: "index"
    rescue
      flash.now[:error] = "Task does not exist"
      redirect_to action: "index"
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :status, :description, :deadline, :category_id)
  end

  def find_task
    @task = Task.find(params[:id])

  rescue
    flash.now[:error] = "Task with id #{params[:id]} does not exist"
    redirect_to action: "index"
  end

  def load_index_data
    @task        = Task.new
    @category    = Category.new
    @comment     = Comment.new
    @categories  = Category.all
    @to_do_tasks = Task.by_status(:to_do)
    @done_tasks  = Task.by_status(:done)
  end
end
