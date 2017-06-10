class Kid < ApplicationRecord
  mount_uploader :picture, PictureUploader
  has_many :favorites
  belongs_to :family
  
  validates :name, presence: true

end
