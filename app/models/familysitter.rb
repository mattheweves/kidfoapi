class FamilySitter < ApplicationRecord
  belongs_to :sitter, class_name: User
  belongs_to :family
end
