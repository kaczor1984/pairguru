class MovieExporterJob < ActiveJob::Base
  def perform(current_user)
    file_path = "tmp/movies.csv"
    MovieExporter.new.call(current_user, file_path)
  end
end
