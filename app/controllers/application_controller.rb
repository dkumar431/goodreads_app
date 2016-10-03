class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def goodread_authorized_url
    request_token = OATH_CONSUMER.get_request_token
    session[:request_token] = request_token
    request_token.authorize_url  
  end

  def goodreads_client
    session[:access_token] ||= session[:request_token].get_access_token
    @client ||= Goodreads.new(oauth_token: session[:access_token])
  end

end
