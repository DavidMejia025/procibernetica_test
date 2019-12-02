class CommentsController < ApplicationController
  def create
    @comment = Comment.new(text: params[:comment][:text], task_id: params[:task_id])

    if @comment.save
      flash.now[:success] = "New Comment was Successfully created"

      task = Task.find(params[:task_id])
      NotificationService.notify(task: task, event: :update)

      respond_to do |format|
        format.js { render js: "tasks/create" }
      end
    else
      flash.now[:error] = "New Comment could not be created"
      redirect_to action: "tasks/create"
    end
  end
end
