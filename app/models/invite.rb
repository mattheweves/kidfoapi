class Invite < ActiveRecord::Base
  INVITE_FOR_SITTER = :for_sitter
  INVITE_FOR_SPOUSE = :for_spouse
  include AASM

  enum invite_kind: {
    INVITE_FOR_SITTER => 0,
    INVITE_FOR_SPOUSE => 1
  }

  enum status: {
    pending: 0,
    accepted: 1,
    rejected: 2,
    canceled: 3
  }

  aasm column: :status, enum: true do
    state :pending, initial: true
    state :accepted
    state :rejected
    state :canceled

    event :accept, after: :create_family_parent_or_sitter do
      transitions from: :pending, to: :accepted
    end

    event :reject do
      transitions from: :pending, to: :rejected
    end

    event :cancel do
      transitions from: :pending, to: :canceled
    end
  end

  belongs_to :family
  belongs_to :user

  validates :email, :invite_kind, presence: true

  before_create { self.code = SecureRandom.hex(32) }
  after_create { InviteMailer.send_invite(self).deliver_later }

  private

  def create_family_parent_or_sitter
    user = User.find_by_email email
    if for_spouse?
      user.update_attribute(:family, family)
    elsif for_sitter?
      if user.families.exists?(family)
        raise ArgumentError, 'User kind and invite kind do not match'
      else
        user.families << family
        if user.family.present?
          user.update_attribute(:role, 3)
        end
      end
    else
      raise ArgumentError, 'User kind and invite kind do not match'
    end
  end
end
