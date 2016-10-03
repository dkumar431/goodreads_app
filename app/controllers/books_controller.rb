class BooksController < ApplicationController
  def owned
    book_details = goodreads_client.owned_books(goodreads_client.user_id)
    binding.pry
    book = Book.new(books_params(book_details))
  end

  private
  def books_params(book_details)
    #   book_api_path = 'book_details["owned_books"]["owned_book"]'
    #   books_arr = []
    #   book_details["owned_books"]["owned_book"].each do |b|
    #     book = {
    #         goodreads_book_id: b["book"]["id"] ,
    #         title: b["book"]["title"] ,
    #         description: b["book"]["description"] ,
    #         publisher: b["book"]["publisher"] ,
    #         link: b["book"]["link"] ,
    #         image_url: b["book"]["image_url"] ,
    #         rating: b["book"]["average_rating"]
    #     }
    #     books_arr.each do |nb|
    #         binding.pry
    #         books_arr << book unless b["book"]["id"] == nb["book"]["id"]
    #     end
        
    #   end
  end

end
