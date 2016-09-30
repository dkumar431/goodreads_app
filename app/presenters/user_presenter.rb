class UserPresenter < SimplePresenter
  
  def get_timeframe
    #h.time_ago_in_words(@user.created_at)
    h.time_ago_in_words(@model.created_at)
  end 
end