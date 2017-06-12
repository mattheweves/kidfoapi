class InviteMailer < ApplicationMailer
  def send_invite(invite)
    @invite = invite
    @for_text = case invite.invite_kind
                when 'for_spouse'
                  'parent'
                when 'for_sitter'
                  'sitter'
      end
    mail to: invite.email, subject: "Invite to become #{@for_text}"
  end
end
