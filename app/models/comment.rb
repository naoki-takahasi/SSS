class Comment < ApplicationRecord
  belongs_to :shop
  belongs_to :sake
end
