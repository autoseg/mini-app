module Orderable
  PERMITED_ORDERS = %w[newest oldest highest_priority lowest_priority complete_first
                    incomplete_first title(asc) title(desc) biggest_score lowest_score]

  def order_records(order)
    if PERMITED_ORDERS.include?(order)
      case order
      when 'newest'
        self.order(created_at: :desc)
      when 'oldest'
        self.order(:created_at)
      when 'highest_priority'
        self.order(priority: :desc)
      when 'lowest_priority'
        self.order(:priority)
      when 'complete_first'
        self.order(status: :desc)
      when 'incomplete_first'
        self.order(:status)
      when 'title(asc)'
        self.order(:title)
      when 'title(desc)'
        self.order(title: :desc)
      when 'biggest_score'
        self.order(score: :desc)
      when 'lowest_score'
        self.order(:score)
      end
    end
  end
end
