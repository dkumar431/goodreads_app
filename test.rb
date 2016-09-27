require 'goodreads'
require 'oauth'

 KEY =  'n5kQqZujrUAQtfjFQ1w7g'
 SECRET = 'G90VW2zngQoQTHmknN6G69C99JuQZxV946LgWSElaE'
 
 request_token = OAuth::Consumer.new(KEY, SECRET, site: 'http://www.goodreads.com').get_request_token

 puts request_token.authorize_url

 access_token = request_token.get_access_token