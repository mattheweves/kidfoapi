class KidsController < ApplicationController
  def index
    kids = Kid.order(name: :asc)
    render json: kids
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
    render json: kid
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
    params.require(:kid).permit(:name, :birthdate, :gender, :allergies)
  end

  def render_errors(kid)
    { errors: kid.errors }
  end
end
