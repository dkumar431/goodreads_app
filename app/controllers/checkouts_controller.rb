class CheckoutsController < ApplicationController
  def new
    user = User.where(id: session[:user_id]).first
    
    if (params[:book_id])
      @book = Book.where(id: params[:book_id]).first
    else 
      redirect_to '/'
    end
    
    @user_p = UserPresenter.new(user,view_context)
    
    @subscription_types = SubscriptionType.all
    @client_token = Braintree::ClientToken.generate
  end

  def index
  end

  def show
  end

  def create
    
    result = Braintree::Transaction.sale(
      :amount => params["amount"],
      :payment_method_nonce => params["nounce"],
      :options => {
        :submit_for_settlement => true
      }
    )
    binding.pry
  end
end
