class Book < ActiveRecord::Base
    has_many :book_relationships
    has_many :users, :through => :book_relationships
end
