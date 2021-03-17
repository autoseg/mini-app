class MinusesController < ApplicationController
  before_action :find_comment, only: %i[create destroy]


  def create
    if minused?
      @minus.destroy
      @comment.update(score: (@comment.score + 1))
      flash[:notice] = 'Comment Unminused'
    elsif plused?
      @plus.destroy
      @comment.update(score: (@comment.score - 1))
      flash[:notice] = 'Comment Unplused'
    else
      @minus = Minuse.create(user: current_user, comment: @comment)
      @minus.save
      @comment.update(score: (@comment.score - 1))
      flash[:notice] = 'Comment Minused'
    end
    redirect_to task_path(@comment.task)
  end


  private

  def find_comment
    @comment = Comment.find(params[:comment_id])
  end

end
