class TasksController < ApplicationController
  before_action :find_task, except: %i[index create]

  def index
    @task  = Task.new
    @tasks = Task.all
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

    if @task.update(task_params)
      flash.now[:success] = "#{@task.title} task was Successfully updated"
      redirect_to action: "index"
    else
      flash.now[:error] = "#{@task.title} task could not be updated"
      redirect_to action: "index"
    end
  end

  def show
    @task = find_task

    respond_to do |format|
      format.js
    end
  end

  def destroy
    puts "destroying the action now"
    @task = Task.find(params[:id])
    @task.destroy

    redirect_to action: "index"
  end

  private

  def task_params
    params.require(:task).permit(:title)
  end

  def find_task
    @task = Task.find(params[:id])

  rescue
    flash.now[:error] = "Task with id #{params[:id]} does not exist"
    redirect_to action: "index"
  end
end
