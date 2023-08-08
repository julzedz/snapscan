class User < ApplicationRecord
  has_many :operations, foreign_key: 'author_id', dependent: :destroy
  has_many :groups, dependent: :destroy

  validates :name, presence: true
end
