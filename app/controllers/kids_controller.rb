class KidsController < ApplicationController

  def index
    @kids = current_user.family.kids
    if @kids.count > 0
      render json: @kids.as_json(include: :favorites)
    else
      render json: render_errors(kid), status: :unprocessable_entity
    end
  end

  def create
    @kid = current_user.family.kids.create(kid_params)
    if @kid.valid?
      render json: @kid, status: :created
    else
      render json: render_errors(@kid), status: :unprocessable_entity
    end
  end

  def show
    @kid = Kid.find(params[:id])
    @family = @kid.family
    render json: @kid.as_json(include: :favorites, include: :family)
  end

  def update
    @kid = Kid.find(params[:id])
    if @kid.update_attributes(convert_data_uri_to_upload(kid_params))
      render json: @kid, status: :ok
    else
      render json: render_errors(@kid), status: :unprocessable_entity
    end
  end

  def destroy
    kid = Kid.find(params[:id])
    kid.destroy
    head :no_content
  end

  def split_base64(uri_str)
		  if uri_str.match(%r{^data:(.*?);(.*?),(.*)$})
		    uri = Hash.new
		    uri[:type] = $1 # "picture/gif"
		    uri[:encoder] = $2 # "base64"
		    uri[:data] = $3 # data string
		    uri[:extension] = $1.split('/')[1] # "gif"
		    return uri
		  else
		    return nil
		  end
    end

  def convert_data_uri_to_upload(obj_hash)
  		  if obj_hash[:picture].try(:match, %r{^data:(.*?);(.*?),(.*)$})
  		    picture_data = split_base64(obj_hash[:picture_url])
  		    picture_data_string = picture_data[:data]
  		    picture_data_binary = Base64.decode64(picture_data_string)

  		    temp_img_file = Tempfile.new("")
  		    temp_img_file.binmode
  		    temp_img_file << picture_data_binary
  		    temp_img_file.rewind

  		    img_params = {:filename => "picture.#{picture_data[:extension]}", :type => picture_data[:type], :tempfile => temp_img_file}
  		    uploaded_file = ActionDispatch::Http::UploadedFile.new(img_params)

  		    obj_hash[:picture] = uploaded_file
  		    obj_hash.delete(:picture_url)
  		  end
  	return obj_hash
  end


  private

  def kid_params
    params.require(:kid).permit(:name, :birthdate, :gender, :allergies, :nonos, :eatdetails, :bedtime, :sleeproutine, :picture, :picture_url, :family_id)
  end

  def render_errors(kid)
    { errors: kid.errors }
  end

end
