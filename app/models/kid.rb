class Kid < ApplicationRecord
  mount_uploader :picture, PictureUploader
  has_many :favorites

  validates :name, presence: true

end
