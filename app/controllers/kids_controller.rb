class KidsController < ApplicationController
  def index
    kids = Kid.order(name: :asc)
    if kids.count > 0
      render json: kids.as_json(include: :favorites)
    else
      render json: render_errors(kid), status: :unprocessable_entity
    end
  end

  def create
    kid = Kid.create(kid_params)
    if kid.valid?
      render json: kid, status: :created
    else
      render json: render_errors(kid), status: :unprocessable_entity
    end
  end

  def show
    kid = Kid.find(params[:id])
    render json: kid.as_json(include: :favorites)
  end

  def update
    kid = Kid.find(params[:id])
    if kid.update_attributes(kid_params)
      render json: kid, status: :ok
    else
      render json: render_errors(kid), status: :unprocessable_entity
    end
  end

  def destroy
    kid = Kid.find(params[:id])
    kid.destroy
    head :no_content
  end

  private

  def kid_params
    params.require(:kid).permit(:name, :birthdate, :gender, :allergies, :nonos, :eatdetails, :sleeproutine, :picture)
  end

  def render_errors(kid)
    { errors: kid.errors }
  end
end
