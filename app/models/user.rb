class User < ActiveRecord::Base
    has_many :book_relationships
    has_many :books, :through => :book_relationships
    has_many :authors, :through => :books

    def self.create_user(user_details)
        user = User.new(user_params(user_details))
    end

    private

    def self.user_params(user_details)
    user = {
      goodreads_user_id: user_details["GoodreadsResponse"]["user"]["id"],
      name: user_details["GoodreadsResponse"]["user"]["name"],
      img_url: user_details["GoodreadsResponse"]["user"]["image_url"],
      gender: user_details["GoodreadsResponse"]["user"]["gender"],
      address: user_details["GoodreadsResponse"]["user"]["location"],
      join_date: user_details["GoodreadsResponse"]["user"]["joined"]
    }
  end

end
