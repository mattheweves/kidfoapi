class Users::RegistrationsController < Devise::RegistrationsController
  include Base64Handler

  def create
  	# check if there already user using the email
    @params = params
    email = @params[:email]
  	if User.find_by_email(email)
  		# stop this create block straight away and show error
  		return render json: {status: "Error", message: "Email already taken"}
  	end

  	# if can't found user using the email, proceed by saving the user
    user = User.new(user_params)
    if user.save
      user.role = "sitteruser"
    	render json: user.as_json(only: [:id, :email, :authentication_token, :family_id])
    else
      render json: render_errors(user), status: :unprocessable_entity
    end
  end

  def update
    @user = current_user
    if @user.update_attributes(convert_data_uri_to_upload(user_params))
      render json: @user, status: :ok
    else
      render json: render_errors(@user), status: :unprocessable_entity
    end

  end

  private

    def render_errors(user)
      { errors: user.errors }
    end

  	def user_params
      params.permit(:email, :motto, :phone_number, :image, :image_url, :first_name, :last_name, :password, :password_confirmation)
    end

    # every time after user change password, destroy all user's token(s)
    # why not make this as after_update callback in User model?
    # because `Tiddle.expire_token(...) method` inside sessions_controller
    # also trigger this method if we make this method as after_update callback
    # when user sign out (destroy session) in HTML,
    # we don't want to delete his/her token. we only want to delete his/her token
    # after he/she change his/her password
    def destroy_all_token(user)
      user.authentication_tokens.destroy_all
      # in JS app, we must sign out the user after they change their password
      # and show a notice saying their `password has been changed successfully`
      # after they log in again, they will get a new token
    end

end
