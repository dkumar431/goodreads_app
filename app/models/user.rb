class User < ActiveRecord::Base
    has_many :book_relationships
    has_many :books, :through => :book_relationships
end
