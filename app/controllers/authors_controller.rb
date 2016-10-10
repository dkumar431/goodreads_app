class AuthorsController < ApplicationController

    def show
        @author = Author.where(id: params[:id]).first
        # response = get_goodreads_access_token.get('https://www.goodreads.com/author/list.xml ',{"key" => API_KEY, "id" => params[:id]})
        # @author_book_details = Hash.from_xml(response.body)
        # binding.pry
    end

end
