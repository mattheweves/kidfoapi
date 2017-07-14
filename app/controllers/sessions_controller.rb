class SessionsController < ApplicationController

  def show
    current_user ? head(:ok) : head(:unauthorized)
  end

  def create
    @user = User.where(email: params[:email]).first
    if @user&.valid_password?(params[:password])
      @user.save
      render json: @user.as_json(only: [:id, :first_name, :last_name, :email, :image, :authentication_token, :family_id]), status: :created
    elsif @user
      head(:unauthorized)
    else
      head(:not_found)
    end
  end

  def destroy
    current_user&.authentication_token = nil
    if current_user&.save
      head(:ok)
    else
      head(:unauthorized)
    end
  end
end
