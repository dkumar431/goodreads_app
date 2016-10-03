  Goodreads::Books.send(:define_method, :owned_books) do |user_id|
    oauth_request("/owned_books/user")
  end

