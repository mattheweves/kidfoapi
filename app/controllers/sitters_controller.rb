class SittersController < ApplicationController

    def index
      @sitters = current_user.family.sitters
      if @sitters.count > 0
        render json: @sitters.as_json
      else
        render json: render_errors(@sitters), status: :unprocessable_entity
      end
    end

    def show
      sitter = User.find(params[:id])
      render json: sitter.as_json
    end

    private

    def render_errors(sitters)
      { errors: sitters.errors }
    end

  end
