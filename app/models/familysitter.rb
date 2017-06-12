class Familysitter < ApplicationRecord
  belongs_to :sitter, class_name: User
  belongs_to :family
end
