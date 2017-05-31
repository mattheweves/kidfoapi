class Favorite < ApplicationRecord
  belongs_to :kid
  
  validates :name, presence: true
end
