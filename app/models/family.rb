class Family < ApplicationRecord
  has_many :users
  has_many :kids

  alias parents users

  def may_invite_spouse?
    parents.count < 2
  end

end
