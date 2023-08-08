class User < ApplicationRecord
  # devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :operations, foreign_key: 'author_id', dependent: :destroy
  has_many :groups, dependent: :destroy

  validates :name, presence: true
end
