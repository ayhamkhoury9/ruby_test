class AddDetailsToReviews < ActiveRecord::Migration[7.1]
  def change
    add_column :reviews, :user, :string
    add_column :reviews, :stars, :integer
    add_column :reviews, :review, :text
  end
end
