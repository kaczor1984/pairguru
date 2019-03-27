class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]

  def index
    @movies = Movie.all.decorate
  end

  def show
    @movie = MovieDecorator.new(Movie.find(params[:id]))
  end

  def send_info
    @movie = Movie.find(params[:id])
    MovieInfoMailerJob.perform_later(current_user, @movie.id)
    redirect_back(fallback_location: root_path, notice: "Email will be sent with movie info")
  end

  def export
    MovieExporterJob.perform_later(current_user)
    redirect_to root_path, notice: "Movies will be exported soon"
  end
end
