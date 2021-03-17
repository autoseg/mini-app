class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_tasks

  def index
  end

  def print_as_pdf
    @emitter = current_user.profile.nickname

    if @tasks.present?
      respond_to do |format|
        format.pdf do
          render pdf: "Tasks_Report.pdf",
          page_size: 'A4',
          template: "reports/print_as_pdf.html.erb",
          layout: false,
          show_as_html: Rails.env.test?
        end
      end
    else
      flash[:alert] = "You need at least one task to generate the report"
      redirect_to report_path(filter: params[:filter])
    end
  end

  private

  def find_tasks
    @tasks = current_user.tasks
    @tasks = @tasks.completed if params[:filter] == 'completed'
    @tasks = @tasks.incomplete if params[:filter] == 'incomplete'
    @tasks = @tasks.includes(:comments).reverse
  end
end
