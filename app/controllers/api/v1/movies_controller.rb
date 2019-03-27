class Api::V1::MoviesController < ApplicationController
  def index
    @movies = Movie.all
    render json: @movies.to_json
  end

  def show
    @movie = MovieDecorator.new(Movie.find(params[:id]))
    render json: @movie.to_json
  end
end
