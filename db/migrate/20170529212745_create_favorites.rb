class CreateFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :favorites do |t|
      t.integer :kid_id
      t.string :category
      t.string :name
      t.string :description
      t.string :image_link
      t.string :book_isbn
      t.string :movie_cast
      t.string :movie_trailer_url

      t.timestamps
    end
  end
end
