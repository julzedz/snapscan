class Operation < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'author_id'
  has_and_belongs_to_many :groups

  validates :name, :amount, :author_id, :user_id, presence: true
  validates :amount, numericality: { greater_than: 0, only_integer: true, less_than: 100_000_000 }
  validates :user_id, presence: true
  validates :author_belongs_to_user

  private

  def author_belongs_to_user
    return if user_id == author_id

    errors.add(:author_id, 'must belong to the same user')
  end
end
