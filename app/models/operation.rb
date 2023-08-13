class Operation < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'author_id'
  has_many :groups

  validates :name, :amount, :author_id, presence: true
  validates :amount, numericality: { greater_than: 0, only_integer: true, less_than: 100_000_000 }
end
