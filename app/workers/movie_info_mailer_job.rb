class MovieInfoMailerJob < ActiveJob::Base
  def perform(current_user, movie_id)
    @movie = Movie.find(movie_id)
    MovieInfoMailer.send_info(current_user, @movie).deliver_now
  end
end
