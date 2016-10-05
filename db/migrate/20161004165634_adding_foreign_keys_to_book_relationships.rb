class AddingForeignKeysToBookRelationships < ActiveRecord::Migration
  def change
    add_foreign_key :book_relationships, :users, column: :user_id, primary_key: "id"
    add_foreign_key :book_relationships, :books, column: :book_id, primary_key: "id"
  end
end
