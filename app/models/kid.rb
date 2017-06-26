class Kid < ApplicationRecord
  mount_base64_uploader :picture, PictureUploader
  #mount_uploader :picture, PictureUploader
  has_many :favorites
  belongs_to :family

  validates :name, presence: true

end
