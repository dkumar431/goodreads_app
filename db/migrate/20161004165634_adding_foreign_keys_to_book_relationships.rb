class AddingForeignKeysToBookRelationships < ActiveRecord::Migration
  def change
    add_foreign_key :book_relationships, :users, column: :user_id, primary_key: "user_id"
    add_foreign_key :book_relationships, :books, column: :book_id, primary_key: "book_id"
  end
end
