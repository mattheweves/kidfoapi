class RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :phone_number, :role, :email, :password, :password_confirmation, :avatar, :motto)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :phone_number, :role, :email, :password, :password_confirmation, :current_password, :avatar, :motto)
  end
end
