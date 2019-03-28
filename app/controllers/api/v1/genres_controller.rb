class Api::V1::GenresController < ApplicationController
  def index
    @genres = Genre.all
    render json: @genres.to_json
  end

  def show
    @genre = Genre.find(params[:id])
    render json: @genre.to_json
  end
end
