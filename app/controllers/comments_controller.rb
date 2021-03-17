class CommentsController < ApplicationController
  before_action :comment_owner?, only: %i[ index ]

  def index
    @comments = Comment.where(user: current_user)
    @comments = @comments.order_by(params[:order]) if params[:order].present?
  end

  def create
    @new_comment = current_user.comments.build(comment_params)

    @new_comment.save ? flash[:notice] = 'Comment Added!' : flash[:alert] = @new_comment.errors.messages.values.join(', ')
    redirect_to task_path(@new_comment.task.id)
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @task    = @comment.task

    @comment.destroy

    flash[:notice] = 'Comment Deleted!'
    redirect_to task_path(@task)
  end

  private

  def comment_params
    params.require(:comment).permit(:task_id,:body)
  end

  def comment_owner?
    @profile = Profile.find(params[:profile_id])
    if !current_user
      redirect_to root_path
    elsif (current_user.profile != @profile and !@profile.share )
      redirect_to root_path
    end
  end
end
