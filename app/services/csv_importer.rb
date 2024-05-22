class CsvImporter
  BATCH_SIZE = 1000

  def initialize(file_path)
    @file_path = file_path
  end

  def import_movies
    SmarterCSV.process(@file_path, chunk_size: BATCH_SIZE) do |chunk|
      movies = chunk.map do |data|
        {
          title: data[:title],
          description: data[:description],
          year: data[:year],
          director: data[:director],
          actor: data[:actor],
          filming_location: data[:filming_location],
          country: data[:country],
          created_at: Time.now,
          updated_at: Time.now
        }
      end
      Movie.insert_all(movies)
    end
    puts "Importing movies from #{@file_path}"
  end

  def import_reviews
    SmarterCSV.process(@file_path, chunk_size: BATCH_SIZE) do |chunk|
      reviews = chunk.map do |data|
        movie = Movie.find_by(title: data[:movie])
        if movie
          {
            movie_id: movie.id,
            user: data[:user],
            stars: data[:stars],
            review: data[:review],
            created_at: Time.now,
            updated_at: Time.now
          }
        else
          Rails.logger.warn "Movie not found for review: #{data.inspect}"
          nil
        end
      end.compact
      Review.insert_all(reviews)
    end
    puts "Importing reviews from #{@file_path}"
  end
end
