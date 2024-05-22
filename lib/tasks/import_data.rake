namespace :import do
  desc "Import movies and reviews from CSV files"
  task movies_and_reviews: :environment do
    require 'csv'

    puts "Deleting existing reviews and movies..."
    Review.delete_all
    Movie.delete_all

    puts "Importing movies..."
    movie_count = 0
    movies = {}
    CSV.foreach(Rails.root.join('lib/assets/movies.csv'), headers: true) do |row|
      movie = Movie.create!(
        title: row['Movie'],
        description: row['Description'],
        year: row['Year'],
        director: row['Director'],
        actor: row['Actor'],
        filming_location: row['Filming location'],
        country: row['Country']
      )
      movies[row['Movie']] = movie.id
      movie_count += 1
      puts "Imported movie: #{movie.title} (ID: #{movie.id})"
    end
    puts "Total movies imported: #{movie_count}"

    puts "Importing reviews..."
    review_count = 0
    CSV.foreach(Rails.root.join('lib/assets/reviews.csv'), headers: true) do |row|
      movie_id = movies[row['Movie']]
      if movie_id
        review = Review.create!(
          movie_id: movie_id,
          user: row['User'],
          stars: row['Stars'],
          review: row['Review']
        )
        review_count += 1
        puts "Imported review for movie ID: #{review.movie_id}"
      else
        puts "Skipping review - Movie: #{row['Movie']} does not exist"
      end
    end
    puts "Total reviews imported: #{review_count}"

    puts "Import completed successfully."
  end
end
