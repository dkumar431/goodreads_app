class UsersController < ApplicationController

  before_action :check_access_token, only: [:show]

  def show
    user = User.where(id: session[:user_id]).first
    @user_p = UserPresenter.new(user,view_context)
  end


  
end
