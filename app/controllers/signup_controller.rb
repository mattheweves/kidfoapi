class SignupController < ApplicationController
#class RegistrationsController < Devise::RegistrationsController
#  respond_to :json

  def create
    @user = User.build(sign_up_params)
    if @user.save
      render :json => @user.as_json(:auth_token=>@user.authentication_token, :email=>@user.email), :status=>201
      return
    else
      warden.custom_failure!
      render :json => @user.errors, :status=>422
    end
  end

  private

  def sign_up_params
    params.require.(:user).permit(:first_name, :last_name, :phone_number, :role, :email, :password, :password_confirmation, :avatar, :motto, :family_id)
  end

  def account_update_params
    params.require.(:user).permit(:first_name, :last_name, :phone_number, :role, :email, :password, :password_confirmation, :current_password, :avatar, :motto, :family_id)
 end
end
