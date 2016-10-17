class BooksController < ApplicationController
  
  def owned
    @user_books = 
      User.joins("inner join book_relationships br 
                    on users.id = br.user_id 
                  inner join books b 
                    on b.id = br.book_id 
                  inner join book_author_relationships bar 
                    on bar.book_id = b.id 
                  inner join authors a 
                    on a.id = bar.author_id ")
      .select("b.title,b.description,b.link,b.image_url,a.name,a.id author_id").where(id: session[:user_id])
  end

  def all
    @available_books =  Book.get_available_books                        
  end
  
  def borrowed

    user = User.where(id: session[:user_id]).first
    @user_p = UserPresenter.new(user,view_context)

    @books = User.select("B.*,S.*")
      .joins("INNER JOIN SUBSCRIPTIONS S 
              ON USERS.ID = S.USER_ID 
            INNER JOIN BOOKS B 
              ON B.ID = S.BOOK_ID")
      .where({id: session[:user_id]})
    
    #user = User.where({id: 10}).first
    #@books = user.subscriptions.includes(:book)  

  end

end
