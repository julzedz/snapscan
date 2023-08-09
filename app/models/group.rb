class Group < ApplicationRecord
  belongs_to :user, class_name: 'User'
  has_and_belongs_to_many :operations dependent: :destroy

  validates :name, :icon, :user_id, presence: true
end
