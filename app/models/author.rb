class Author < ActiveRecord::Base
    has_many :book_author_relationships
    has_many :books, through: :book_author_relationships 

    ALLOWED_KEYS = %w(id name image_url link).freeze
    
    API_KEYS = %w(id).freeze
    AUTHOR_KEYS = %w(goodreads_author_id ).freeze

    def build_author(author_details)
      self.assign_attributes(author_params(author_details))    
    end

    private

    def author_params(author)
      param_attributes = author.select { |key,_| ALLOWED_KEYS.include? key }
      
      AUTHOR_KEYS.zip(API_KEYS).each {  |new_key, old_key| param_attributes[new_key] = param_attributes.delete(old_key) }
      param_attributes
    end
end
