class ImportCsvJob < ApplicationJob
  queue_as :default

  def perform(file_path, type)
    puts "Starting import job for #{type} with file #{file_path}"
    importer = CsvImporter.new(file_path)

    case type
    when 'movies'
      importer.import_movies
    when 'reviews'
      importer.import_reviews
    else
      raise ArgumentError, "Unknown import type: #{type}"
    end
    puts "Completed import job for #{type} with file #{file_path}"
  rescue => e
    puts "Error in import job: #{e.message}"
  end
end
