class RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :phone_number, :role, :email, :password, :password_confirmation, :avatar, :motto, :family_id)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :phone_number, :role, :email, :password, :password_confirmation, :current_password, :avatar, :motto, :family_id)
  end
end
