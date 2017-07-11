class KidsController < ApplicationController
  include Base64Handler

  def index
    @kids = current_user.family.kids
    if @kids.count > 0
      render json: @kids.as_json(include: :favorites, include: :family)
    else
      render json: render_errors(@kids), status: :unprocessable_entity
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

  private

  def kid_params
    params.permit(:name, :birthdate, :gender, :allergies, :nonos, :eatdetails, :bedtime, :sleeproutine, :image, :image_url, :family_id)
  end

  def render_errors(kid)
    { errors: kid.errors }
  end

end
