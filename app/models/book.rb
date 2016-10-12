class Book < ActiveRecord::Base
    has_many :book_relationships
    has_many :users, :through => :book_relationships

    has_many :book_author_relationships
    has_many :authors, :through => :book_author_relationships

    def create_unique_books( book_details )
        unique_books(book_details).each do |book|
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
          user.save
        end
    end

    private

    def unique_books(book_details)
      books_arr = []
      book_details["GoodreadsResponse"]["owned_books"]["owned_book"].each do |b|
        book = {
            goodreads_book_id: b["book"]["id"] ,
            title: b["book"]["title"] ,
            description: b["book"]["description"] ,
            publisher: b["book"]["publisher"] ,
            link: b["book"]["link"] ,
            image_url: b["book"]["image_url"] ,
            rating: b["book"]["average_rating"],
            authors: b["book"]["authors"]
        }
        books_arr << book 
      end
      books_arr.uniq {|ele| ele[:goodreads_book_id]}
  end

end
