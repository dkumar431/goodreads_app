class UserPresenter 
  
  attr_reader :user
  
  def initialize user, view
    @user = user
    @view = view
  end  
  
  def get_timeframe
    h.time_ago_in_words(@user.created_at)
  end
  
  private

  def h
    @view
  end
end