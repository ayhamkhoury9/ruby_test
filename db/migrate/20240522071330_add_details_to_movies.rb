class AddDetailsToMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :description, :text
    add_column :movies, :year, :integer
    add_column :movies, :director, :string
    add_column :movies, :actor, :string
    add_column :movies, :filming_location, :string
    add_column :movies, :country, :string
  end
end
