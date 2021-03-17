class TasksController < ApplicationController
  before_action :authenticate_user!, only: %i[index new create edit update destroy search]
  before_action :user_profile?
  before_action :find_task, only: %i[edit update change_privacy change_status confirm_delete destroy delete_comment]
  before_action :check_completition, only: %i[edit update]
  skip_before_action :verify_authenticity_token, only: %i[search]


  def index
    @tasks = current_user.tasks
    @tasks = @tasks.order_by(params[:order_tasks]) if params[:order_tasks]
    @order_options = %w[newest oldest highest_priority lowest_priority complete_first incomplete_first title(asc) title(desc)]

    if params[:search].present?
      search_params = sanitize_sql_like(params[:search])

      @tasks = @tasks.where('title LIKE ?', "%#{search_params}%")
    end
  end

  def show
    @task = Task.find(params[:id])
    @comments = @task.comments
    @comments = @comments.order_by(params[:order_comments]) if params[:order_comments]
    @new_comment = current_user.comments.build

    redirect_to root_path if !@task.share && @task.user != current_user
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      flash[:notice] = 'Task Created!'
      redirect_to @task
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:notice] = 'Task Updated!'
      redirect_to @task
    else
      render :new
    end
  end

  def destroy
    @task.destroy

    flash[:notice] = 'Task Deleted!'
    redirect_to tasks_url
  end

  def change_status
    new_status = @task.status == 'complete' ? 'incomplete' : 'complete'
    @task.update(status: new_status)

    flash[:notice] = "Task status changed to #{@task.status.capitalize}"
    redirect_to @task
  end

  def change_privacy
    @task.update(privacy_params)

    flash[:notice] = "Task is #{@task.share ? 'Public' : 'Private'}"
    redirect_to @task
  end

  private

  def find_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :status, :share, :priority)
  end

  def privacy_params
    params.require(:task).permit(:share)
  end

  def check_completition
    if @task.complete?
      flash[:alert] = 'Cannot edit completed task!'
      redirect_to @task
    end
  end

  def sanitize_sql_like(string, escape_character = "\\")
    pattern = Regexp.union(escape_character, "%", "_")
    string.gsub(pattern) { |x| [escape_character, x].join }
  end
end
