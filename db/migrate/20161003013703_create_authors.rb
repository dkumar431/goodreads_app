class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.integer :goodreads_author_id
      t.string :name
      t.string :image_url
      t.string :book_url
      t.float :rating

      t.timestamps null: false
    end
  end
end
