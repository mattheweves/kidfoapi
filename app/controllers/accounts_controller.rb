class AccountsController < ApplicationController
  include Base64Handler

  respond_to :json

  def show
    user = current_user
    if user
      render json: user.as_json
    else
      head(:unauthorized)
    end

  end

  def update
    user = current_user
    if user.update_attributes(convert_data_uri_to_upload(user_params))
      render json: user, status: :ok
    else
      render json: render_errors(user), status: :unprocessable_entity
    end

  end

  private

    def render_errors(user)
      { errors: user.errors }
    end

  	def user_params
      params.permit(:email, :image, :image_url, :first_name, :last_name, :phone_number, :password, :password_confirmation)
    end

end
