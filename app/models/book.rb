class Book < ActiveRecord::Base
    has_many :book_relationships
    has_many :users, :through => :book_relationships

    has_many :book_author_relationships
    has_many :authors, :through => :book_author_relationships

    ALLOWED_KEYS = %w(id title description publisher link image_url average_rating authors).freeze
    
    API_KEYS = %w(id average_rating).freeze
    BOOK_KEYS = %w(goodreads_book_id rating).freeze

    def self.all_goodread_book_ids
      all_book_ids =  Book.pluck(:goodreads_book_id)
    end

    def self.build_books(owned_books)
      
      unique_books!(owned_books)
      goodread_book_ids = owned_books.map{ |book| book['id'] }
      new_book_ids = goodread_book_ids - Book.all_goodread_book_ids
      new_book_details = owned_books.select { |book| book if new_book_ids.include?(book['id']) }

      books_arr = []
      new_book_details.each do |book|
        books_arr << book.select{ |key,_| ALLOWED_KEYS.include? key }  
      end
      books_arr.each do |book|
        BOOK_KEYS.zip(API_KEYS).each { |new_key, old_key| book[new_key] = book.delete(old_key) }
      end
      
      final_arr = []
      books_arr.each do |book_info|
        author = Author.new
        author.build_author(book_info["authors"]["author"])
        book = Book.new(book_info.except("authors"))
        
        book.authors << author
        final_arr << book
      end
      
      final_arr
    end

    def self.unique_books!(book_details)
      book_details.uniq! {|ele| ele["id"]}
    end



=begin
    def self.get_book(book_id)
      Book.where(id: book_id).first
    end

    def self.get_available_books
      raw_sql = "select *, book_count-subs_count as available from (
                  select total.id,total.title,total.image_url,total.book_count,COALESCE(subs.subs_count,0) subs_count
                  from		
                    (select book_id,count(s.book_id) subs_count from subscriptions s where s.is_active = 1 GROUP BY s.book_id) as subs
			                right join
			              (select b.id,b.title,b.image_url,count(br.book_id) book_count from book_relationships br inner join books b 
				              on b.id = br.book_id group by br.book_id) as total
			            on subs.book_id = total.id
              )a"
      ActiveRecord::Base.connection.select_all(raw_sql)
    end


    def self.create_unique_books( book_details, user )
      user_books = unique_books(book_details)
      if user_books
        user_books.each do |book|
          existing_book = Book.where(goodreads_book_id: book[:goodreads_book_id])

          if existing_book.blank?
            new_book = Book.new({
              goodreads_book_id: book[:goodreads_book_id] ,
              title: book[:title] ,
              description: book[:description] ,
              publisher: book[:publisher] ,
              link: book[:link] ,
              image_url: book[:image_url] ,
              rating: book[:average_rating]
            }) 

            author = Author.new({
              goodreads_author_id: book[:authors]["author"]["id"],
              name: book[:authors]["author"]["name"],
              image_url: book[:authors]["author"]["image_url"],
              link: book[:authors]["author"]["link"],
              rating: book[:authors]["author"]["average_rating"]
            })
            
            user.books << new_book
            new_book.authors << author
          else 
            user.books << existing_book   
          end
        end
      end
      user.save
    end

    private

    def self.unique_books(book_details)
      
      books_arr = book_details["GoodreadsResponse"]["owned_books"]["owned_book"]
      books_arr.uniq {|ele| ele["book"]["id"]}
      
      # books_arr = []
      # return if book_details["GoodreadsResponse"]["owned_books"]["owned_book"].nil? 
      # book_details["GoodreadsResponse"]["owned_books"]["owned_book"].each do |b|
      #   book = {
      #       goodreads_book_id: b["book"]["id"] ,
      #       title: b["book"]["title"] ,
      #       description: b["book"]["description"] ,
      #       publisher: b["book"]["publisher"] ,
      #       link: b["book"]["link"] ,
      #       image_url: b["book"]["image_url"] ,
      #       rating: b["book"]["average_rating"],
      #       authors: b["book"]["authors"]
      #   }
      #   books_arr << book 
      # end
      # books_arr.uniq {|ele| ele[:goodreads_book_id]}
  end
=end  

end
