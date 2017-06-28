class Kid < ApplicationRecord
  mount_base64_uploader :image, ImageUploader

  has_many :favorites
  belongs_to :family

  validates :name, presence: true

end
