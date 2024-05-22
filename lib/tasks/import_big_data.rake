namespace :import do
  desc "Import movies and reviews from CSV files"
  task import_movies_and_reviews: :environment do
    file_path_movies = ENV['MOVIES_FILE_PATH'] || 'lib/assets/movies.csv'
    file_path_reviews = ENV['REVIEWS_FILE_PATH'] || 'lib/assets/reviews.csv'

    puts "Movies file path: #{file_path_movies}"
    puts "Reviews file path: #{file_path_reviews}"

    if File.exist?(file_path_movies) && File.exist?(file_path_reviews)
      ImportCsvJob.perform_later(file_path_movies, 'movies')
      ImportCsvJob.perform_later(file_path_reviews, 'reviews')
      puts "Import jobs enqueued"
    else
      puts "Please ensure that the CSV files exist at the specified paths"
    end
  end
end
