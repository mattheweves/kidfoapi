class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  def protect_against_forgery?
    false
  end
end
