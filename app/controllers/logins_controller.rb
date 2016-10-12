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

      goodreads_user_details = GR::get_goodreads_user_details(goodreads_client, user_id) 
      user = User.create_user(goodreads_user_details)

      goodreads_book_details = GR::get_goodreads_owned_books( goodreads_client, user_id )
      books = Book.create_unique_books(goodreads_book_details,user)

    end

    session[:user_id] = user.id
    redirect_to users_path
  end

  

  

end