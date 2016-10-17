class GR

  def initialize (client)
    @client = client
    @user_id = nil
  end  

  def get_user_id
    @response = @client.get('/api/auth_user')
    @user_id ||= response_body["GoodreadsResponse"]["user"]["id"]
  end

  def get_user_details
    return @user_details if @user_details.present?
    @response = @client.get('/user/show/'+@user_id+'.xml',{"key" => API_KEY})
    @user_details ||= response_body["GoodreadsResponse"]["user"]
  end

  def get_owned_books
    @response = @client.get('/owned_books/user?format=xml', {"id" => @user_id})
    response_body['GoodreadsResponse']['owned_books']['owned_book'].map{|x| x['book'] }
  end

  def save_user_details!
    user = User.where(goodreads_user_id: get_user_id).first
    return user if user.present?

    user = User.new
    user.build_user(get_user_details)
    user.books = Book.build_books(get_owned_books)
    user.save!
    user
  end

  private
  def response_body
    Hash.from_xml(@response.body)
  end

end