class MoviesController < ApplicationController
  def index
    @movies = if params[:actor].present?
                Movie.where("actor ILIKE ?", "%#{params[:actor]}%")
              else
                Movie.all
              end
    @movies = @movies.order(average_rating: :desc)
  end
end
