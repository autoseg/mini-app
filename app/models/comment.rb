class Comment < ApplicationRecord
  extend Orderable

  enum like_status: {neither: 0, like: 10, dislike: 20}

  validates :body, presence: {message: 'Comment body can\'t be blank'}

  belongs_to :user
  belongs_to :task
  has_many :pluses, dependent: :destroy
  has_many :minuses, dependent: :destroy

  def owner
    user.profile
  end

  def self.order_by(order)
    self.order_records(order)
  end

end
