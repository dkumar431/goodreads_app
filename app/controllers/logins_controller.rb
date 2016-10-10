class LoginsController < ApplicationController

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

  private
  
  def fetch_all_user_details
    response = get_goodreads_access_token.get('/api/auth_user')
    user_id = Hash.from_xml(response.body)["GoodreadsResponse"]["user"]["id"]
    user = User.where(goodreads_user_id: user_id).first
    
    if user.blank?   
      res = get_goodreads_access_token.get('/user/show/'+user_id+'.xml',{"key" => API_KEY})
      user_details = Hash.from_xml(res.body)
      new_user = User.new(user_params(user_details))
      new_user.save
      user = new_user
        
      res = get_goodreads_access_token.get('/owned_books/user?format=xml', {"id" => user_id})
      book_details = Hash.from_xml(res.body)

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
          b.authors << a 
          user.books << b
    
          user.save
          b.save
        end
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
      books_arr.uniq! {|ele| ele[:goodreads_book_id]}
  end

end