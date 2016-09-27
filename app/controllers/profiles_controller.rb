class ProfilesController < ApplicationController
  def index
    consumer = OAuth::Consumer.new(Goodreads.configuration[:api_key],
                                    Goodreads.configuration[:api_secret],
                                    :site => 'http://www.goodreads.com')
    request_token = consumer.get_request_token  
    
    redirect_to request_token.authorize_url
    
    
   
  end
  def callback
    # response = HTTParty.get('https://www.goodreads.com/api/auth_user')
    # binding.pry
    render json: {}
    # client = Goodreads::Client.new(api_key: Goodreads.configuration[:api_key], api_secret: Goodreads.configuration[:api_secret])
    
  end
end
