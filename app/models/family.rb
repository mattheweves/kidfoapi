class Family < ApplicationRecord
  has_many :users
  has_many :kids
  has_many :invites
  has_many :familysitters
  has_many :sitters, through: :familysitters

  alias parents users

  def may_invite_spouse?
    parents.count < 2
  end

end
