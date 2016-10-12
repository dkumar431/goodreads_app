module GR

  def self.get_goodreads_user_id( client )
    response = client.get('/api/auth_user')
    user_id = Hash.from_xml(response.body)["GoodreadsResponse"]["user"]["id"]
  end

  def self.get_goodreads_user_details( client, user_id )
    response = client.get('/user/show/'+user_id+'.xml',{"key" => API_KEY})
    user_details = Hash.from_xml(response.body)
  end

  def self.get_goodreads_owned_books( client, user_id )
    response = client.get('/owned_books/user?format=xml', {"id" => user_id})
    book_details = Hash.from_xml(response.body)
  end

end