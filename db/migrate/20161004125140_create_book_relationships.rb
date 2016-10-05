class CreateBookRelationships < ActiveRecord::Migration
  def change
    create_table :book_relationships do |t|
      t.integer :user_id
      t.integer :book_id
      t.string :type

      t.timestamps null: false
    end
  end
end
