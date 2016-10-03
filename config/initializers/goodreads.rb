require 'goodreads'


API_KEY = "n5kQqZujrUAQtfjFQ1w7g".freeze
API_SECRET =  "G90VW2zngQoQTHmknN6G69C99JuQZxV946LgWSElaE".freeze
GOODREADS_SITE = 'http://www.goodreads.com'.freeze
OATH_CONSUMER ||=  OAuth::Consumer.new(API_KEY,API_SECRET, :site => GOODREADS_SITE)   

GREADS = {}
GREADS[:get_user_url] = 'http://www.goodreads.com/user/show'
GREADS[:get_user_books] = "https://www.goodreads.com/owned_books/user?format=xml"