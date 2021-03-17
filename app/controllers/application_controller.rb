class ApplicationController < ActionController::Base

  def user_profile?
    if current_user && current_user.profile == nil
      redirect_to new_profile_path
    end
  end

  private

  def plused?
    @plus = current_user.pluses.find_by(comment: @comment).presence
  end

  def minused?
    @minus = current_user.minuses.find_by(comment: @comment).presence
  end
end
