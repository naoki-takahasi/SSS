class Brewery < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  has_many :sakes,         dependent: :destroy
  has_many :relationships, dependent: :destroy

  def followed_by?(user)
    relationships.exists?(shop_id: user.id)
  end

  validates :name,    presence: true
  validates :post,    presence: true
  validates :address, presence: true
  validates :tel,     presence: true
  validates :email,   presence: true
end
