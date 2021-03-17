class Task < ApplicationRecord
  extend Orderable

  enum priority: {low: 0, medium: 10, high: 20}
  enum status: {incomplete: 0, complete: 10}

  validates :title, length: {minimum: 4}
  validates :title, length: {maximum: 20}
  validates :description, presence: true
  validates :description, length: {maximum: 280}

  belongs_to :user
  has_many :comments, dependent: :destroy

  scope :completed, -> { where(status: 'complete') }
  scope :incomplete, -> { where(status: 'incomplete') }

  def self.options_for_priority_select
    priorities.keys.map { |p| [ p.capitalize, p ] }
  end

  def self.order_by(order)
    self.order_records(order)
  end

end
