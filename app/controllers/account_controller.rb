class AccountController < ApplicationController
  respond_to :json

  def create
    user = User.new(account_params)
        if user.save
          render :json => user.as_json, :status=>201
          return
        else
          render :json => user.errors, :status=>422
        end
  end


  private

  def account_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
