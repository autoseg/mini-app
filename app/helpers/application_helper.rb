module ApplicationHelper

  def format_date(date)
    date.strftime('%m/%d/%Y')
  end

  def format_date_time(date)
    date.strftime('%m/%d/%Y at %l:%M %p')
  end

  def user_is_owner?(user)
    current_user == user
  end
end
