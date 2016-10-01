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
    @user = User.find_by_goodreads_user_id(params[:id])
    
    if @user.blank? 
      response = RestClient.get(GREADS[:get_user_url],params: goodreads_params(params[:id]))
      user_details = Hash.from_xml(response)
      @new_user = User.new(user_params(user_details))
      @new_user.save
      @user = @new_user
    end
    @user_p = UserPresenter.new(@user,view_context)
  end
  
  def my_books
    response = RestClient.get(GREADS[:get_user_books], params: {id: params[:id]})
    
    binding.pry
  end

  private
  def goodreads_params(id)
    { id: id,  format: 'xml', key: 'n5kQqZujrUAQtfjFQ1w7g' }
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

end
