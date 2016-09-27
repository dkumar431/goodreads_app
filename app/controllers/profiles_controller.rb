class ProfilesController < ApplicationController
  def index
    consumer = OAuth::Consumer.new(Goodreads.configuration[:api_key],
                                    Goodreads.configuration[:api_secret],
                                    :site => 'http://www.goodreads.com')
    request_token = consumer.get_request_token  
    redirect_to request_token.authorize_url
  end

  def callback  
  end

  def show
    binding.pry
    user_details = 
    RestClient.get('http://www.goodreads.com/user/show',params: goodreads_params('25814733'))
    
  end

  private
  def goodreads_params(id)
    { id: id,  format: 'xml', key: 'n5kQqZujrUAQtfjFQ1w7g' }
  end

end
