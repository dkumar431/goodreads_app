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
    client = GR.new(goodreads_client)
    user = client.save_user_details!
    session[:user_id] = user.id
    redirect_to users_path
  end  

  def logout
    reset_session
    redirect_to '/'
  end

end