class TasksController < ApplicationController
  def index
  end

  def new
  end

  def create
    @task = Task.new(title: params[:title])

    if @task.save
      flash.now[:success] = "New Task was Successfully created"

      redirect_to action: "index"
    else
      redirect_to action: "new"
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
