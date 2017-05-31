class FavoritesController < ApplicationController

  def create
    kid = Kid.find(params[:kid_id])
    favorite = kid.favorites.create(favorite_params)
    if favorite.invalid?
      render json: render_errors(favorite), status: :unprocessable_entity
    end
  end

  def destroy
    favorite = Favorite.find(params[:id])
    favorite.destroy
    head :no_content
  end

  private

  def favorite_params
    params.require(:favorite).permit(:type, :name, :description, :image_link, :book_isbn, :movie_cast, :movie_trailer_url)
  end

  def render_errors(favorite)
    { errors: favorite.errors }
  end


end
