class FamiliesController < ApplicationController

  def index
    @families = current_user.families
    if @families.count > 0
      render json: @families.as_json(include: [:kids, :parents ])
    else
      render json: render_errors(@families), status: :unprocessable_entity
    end
  end

  def show
    family = Family.find(params[:id])
    render json: family.as_json(include: [:kids, :parents ])
  end

  private

  def render_errors(families)
    { errors: families.errors }
  end

end
