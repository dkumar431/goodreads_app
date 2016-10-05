class UsersController < ApplicationController

  before_action :check_access_token, only: [:my_books, :login]

  def login
  end

  def authenticate  
    redirect_to goodread_authorized_url  
  end

  def show
    user = User.where(goodreads_user_id: goodreads_client.user_id).first
    if user.blank? 
      
      user_details = goodreads_client.user(goodreads_client.user_id)
      new_user = User.new(user_params(user_details))
      new_user.save
      user = new_user
      
      book_details = goodreads_client.owned_books(goodreads_client.user_id)
      books_params(book_details).each do |book|
        b = Book.new(book)
        b.save
        user.books << b
      end
      
      
    end
    @user_p = UserPresenter.new(user,view_context)
    
  end

  private
  def goodreads_params(id)
    { id: id,  format: 'xml', key: 'n5kQqZujrUAQtfjFQ1w7g' }
  end
  
  def check_access_token
    redirect_to authenticate_users_path and return if session[:access_token].blank?
    redirect_to users_path if params[:action] == 'login' 
  end
  
  def user_params(user_details)
    user = {
      goodreads_user_id: user_details["id"],
      name: user_details["name"],
      img_url: user_details["image_url"],
      gender: user_details["gender"],
      address: user_details["location"],
      join_date: user_details["joined"]
    }
  end

  def books_params(book_details)
      books_arr = []
      book_details["owned_books"]["owned_book"].each do |b|
        book = {
            goodreads_book_id: b["book"]["id"] ,
            title: b["book"]["title"] ,
            description: b["book"]["description"] ,
            publisher: b["book"]["publisher"] ,
            link: b["book"]["link"] ,
            image_url: b["book"]["image_url"] ,
            rating: b["book"]["average_rating"]
        }
        books_arr << book 
      end
      books_arr.uniq! {|ele| ele[:goodreads_book_id]}
  end

  
end
