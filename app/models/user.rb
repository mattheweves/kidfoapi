class User < ApplicationRecord
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :family
  has_many :kids, through: :family

  # INVITES
  # User A Sent Invitation to Sitter, hence We call it Invites
  has_many :invites

  #Sitters
  has_many :familysitters, foreign_key: :sitter_id
  has_many :families, through: :familysitters, source: :family


  # Received Invitations
  # Receive Invitation from User A, We call it invitation
  has_many :invitations, foreign_key: :email,
                         primary_key: :email,
                         class_name: 'Invite'

  enum role: {
    # Person with Kids, Family, But Does not Sit for Others
    parentuser: 1,
    # Person who watches for families, but doesn't have family.
    sitteruser: 2,
    # Person with Kids, Family, also been invited to view/sit for other families.
    parentsitteruser: 3
  }

  def build_family
    build_family(name: last_name) unless family.present?
  end

  def set_role

  end

end
