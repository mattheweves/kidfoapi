class InvitesController < ApplicationController
  before_action :set_invite, only: [:show, :accept, :reject, :cancel]
  #load_and_authorize_resource param_method: :invite_params

  def index
    @email = current_user.email
    @invites = Invite.where(email: @email).select { |invite| invite.status == 'pending' }
    if @invites
      render json: @invites
    else
      head :ok
    end
  end

  def new
    @invite = current_user.invites.new
    @family = current_user.family

    case (@invite.invite_kind || params[:invite_kind])
    when 'for_spouse'
      @invite.invite_kind = 'for_spouse'
    when 'for_sitter'
      @invite.invite_kind = 'for_sitter'
    else
      redirect_to user_path(current_user)
    end
  end

  def create
    @invite = current_user.invites.new invite_params
    @invite.status = :pending
    @invite.family = current_user.family

    if @invite.save
      render json: @invite, status: :created, notice: "Invite is sent to #{@invite.email}"
    else
      render json: render_errors(@invite)
    end
  end

  def show
  end

  def accept
    @invite = Invite.find(params[:id])
    @invite.accept!
    if @invite.invite_kind = 'for_spouse'
      if current_user.families.exists? && current_user.families.count > 0
         current_user.role = 'parentsitteruser'
      else current_user.role = 'parentuser'
      end
    end
  end

  def reject
    @invite = Invite.find(params[:id])
    @invite.reject!
    render json: @invite, status: :rejected, notice: 'Reject invite successfully!'
  end

  def cancel
    @invite.cancel!
    redirect_to root_path, notice: 'Cancel invite successfully!'
  end

  private

  def invite_params
    params.require(:invite).permit :email, :invite_kind
  end

  def set_invite
    @invite = Invite.find_by_code params[:id]
  end

  def render_errors(invite)
    { errors: invite.errors }
  end

end
