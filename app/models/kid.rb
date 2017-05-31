class Kid < ApplicationRecord
  has_many :favorites

  validates :name, presence: true

end
