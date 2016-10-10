class Book < ActiveRecord::Base
    has_many :book_relationships
    has_many :users, :through => :book_relationships

    has_many :book_author_relationships
    has_many :authors, :through => :book_author_relationships


end
