class Movie < ApplicationRecord
  has_many :reviews, dependent: :destroy

  def update_average_rating
    self.average_rating = reviews.average(:stars).to_f
    save
  end
end
