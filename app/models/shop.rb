class Shop < ApplicationRecord
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

  def self.guest
    find_or_create_by!(name: '閲覧者', email: 'guest@example.com') do |shop|
      shop.password = SecureRandom.urlsafe_base64
      shop.post = '000-0000'
      shop.address = 'guest'
      shop.tel = '00-0000-0000'
    end
  end

  validates :name,    presence: true
  validates :post,    presence: true
  validates :address, presence: true
  validates :tel,     presence: true
  validates :email,   presence: true
end
