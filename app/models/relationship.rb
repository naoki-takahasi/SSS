class Relationship < ApplicationRecord
  belongs_to :brewery
  belongs_to :shop
end
