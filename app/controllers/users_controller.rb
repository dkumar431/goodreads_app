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
    end
    @user_p = UserPresenter.new(user,view_context)
    
  end

  private
  def goodreads_params(id)
    { id: id,  format: 'xml', key: 'n5kQqZujrUAQtfjFQ1w7g' }
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

  def book_params
  end

  def check_access_token
    redirect_to authenticate_users_path and return if session[:access_token].blank?
    redirect_to users_path if params[:action] == 'login' 
  end
end
