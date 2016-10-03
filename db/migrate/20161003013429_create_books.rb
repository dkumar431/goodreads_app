class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer :goodreads_book_id
      t.string :title
      t.string :description
      t.string :publisher
      t.string :link
      t.string :image_url
      t.float :rating

      t.timestamps null: false
    end
  end
end
