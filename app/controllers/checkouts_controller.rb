class CheckoutsController < ApplicationController
  def new
    user = User.where(id: session[:user_id]).first
    @user_p = UserPresenter.new(user,view_context)
    @client_token = Braintree::ClientToken.generate
  end

  def index
  end

  def show
  end
end
