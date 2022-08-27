class Comment < ApplicationRecord
  belongs_to :shop
  belongs_to :sake

  validates :comment, presence: true
end
