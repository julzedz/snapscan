class Group < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: :author_id
  has_many :operations, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 }
  validates :icon, presence: true

  def recent_transactions
    operations.order(created_at: :desc).limit(5)
  end
end
