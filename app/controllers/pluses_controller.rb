class PlusesController < ApplicationController
  before_action :find_comment, only: %i[create]


  def create
    if plused?
      @plus.destroy
      @comment.update(score: (@comment.score - 1))
      flash[:notice] = 'Comment Unplused'
    elsif minused?
      @minus.destroy
      @comment.update(score: (@comment.score + 1))
      flash[:notice] = 'Comment Unminused'
    else
      @plus = Pluse.create(user: current_user, comment: @comment)
      @plus.save
      flash[:notice] = 'Comment Plused'
      @comment.update(score: (@comment.score + 1))
    end
    redirect_to task_path(@comment.task)
  end

  private

  def find_comment
    @comment = Comment.find(params[:comment_id])
  end

end
