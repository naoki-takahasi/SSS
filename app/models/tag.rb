class Tag < ApplicationRecord
  has_many :sakes
  validates :name, presence: true
end
