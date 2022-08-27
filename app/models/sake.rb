class Sake < ApplicationRecord
  has_one_attached :image

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  belongs_to :brewery
  belongs_to :tag
  has_many :favorites, dependent: :destroy
  has_many :comments,  dependent: :destroy

  validates :name,    presence: true
  validates :explain, presence: true
  validates :tag_id,  presence: true
  validates :price,   presence: true

  def favorited_by?(shop)
    favorites.exists?(shop_id: shop.id)
  end
end
