class SessionsController < ApplicationController
  #acts_as_token_authentication_handler_for User, only: [:destroy]

  def show
    current_user ? head(:ok) : head(:unauthorized)
  end

  def create
    @user = User.where(email: params[:email]).first

    if @user&.valid_password?(params[:password])
      render json: @user.as_json(only: [:id, :email, :authentication_token]), status: :created
    else
      head(:unauthorized)
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
