class LoginsController < ApplicationController

  include GR

  def show
  end

  def authenticate  
    request_token = OATH_CONSUMER.get_request_token
    session[:request_token] = request_token
    redirect_to request_token.authorize_url   
  end

  def callback
    session[:access_token] ||= session[:request_token].get_access_token
    fetch_all_user_details
  end  

  def logout
    reset_session
    redirect_to '/'
  end

  private
  
  def fetch_all_user_details
    user_id = GR::get_goodreads_user_id(goodreads_client)
    user = User.where(goodreads_user_id: user_id).first
    
    if user.blank?   
      user_details = GR::get_goodreads_user_details(goodreads_client, user_id)
      user = User.new(user_params(user_details))
        
      book_details = GR::get_goodreads_owned_books( goodreads_client, user_id )

      unique_books(book_details).each do |book|
        bk = Book.where(goodreads_book_id: book[:goodreads_book_id])
        if bk.blank?
          b = Book.new({
            goodreads_book_id: book[:goodreads_book_id] ,
            title: book[:title] ,
            description: book[:description] ,
            publisher: book[:publisher] ,
            link: book[:link] ,
            image_url: book[:image_url] ,
            rating: book[:average_rating]
          }) 

          a = Author.new({
            goodreads_author_id: book[:authors]["author"]["id"],
            name: book[:authors]["author"]["name"],
            image_url: book[:authors]["author"]["image_url"],
            link: book[:authors]["author"]["link"],
            rating: book[:authors]["author"]["average_rating"]
          })
           
          user.books << b
          b.authors << a
        else 
          user.books << bk   
        end
        user.save
      end
    end

    session[:user_id] = user.id
    redirect_to users_path
  end

  def user_params(user_details)
    user = {
      goodreads_user_id: user_details["GoodreadsResponse"]["user"]["id"],
      name: user_details["GoodreadsResponse"]["user"]["name"],
      img_url: user_details["GoodreadsResponse"]["user"]["image_url"],
      gender: user_details["GoodreadsResponse"]["user"]["gender"],
      address: user_details["GoodreadsResponse"]["user"]["location"],
      join_date: user_details["GoodreadsResponse"]["user"]["joined"]
    }
  end

  def unique_books(book_details)
      books_arr = []
      book_details["GoodreadsResponse"]["owned_books"]["owned_book"].each do |b|
        book = {
            goodreads_book_id: b["book"]["id"] ,
            title: b["book"]["title"] ,
            description: b["book"]["description"] ,
            publisher: b["book"]["publisher"] ,
            link: b["book"]["link"] ,
            image_url: b["book"]["image_url"] ,
            rating: b["book"]["average_rating"],
            authors: b["book"]["authors"]
        }
        books_arr << book 
      end
      books_arr.uniq {|ele| ele[:goodreads_book_id]}
  end

end