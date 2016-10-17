class User < ActiveRecord::Base
    has_many :book_relationships
    has_many :books, :through => :book_relationships
    has_many :authors, :through => :books
    has_many :subscriptions

    ALLOWED_KEYS = %w(id name image_url gender location joined).freeze
    API_KEYS = %w(id joined image_url location).freeze
    USER_KEYS = %w(goodreads_user_id join_date img_url address).freeze

    def build_user(user_details)
      self.assign_attributes(user_params(user_details))
    end

    private
    def user_params(user_details)
      param_attributes = user_details.select { |key,_| ALLOWED_KEYS.include? key }
      USER_KEYS.zip(API_KEYS).each {  |new_key, old_key| param_attributes[new_key] = param_attributes.delete(old_key) }
      param_attributes
    end
end
