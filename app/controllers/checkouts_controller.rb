class CheckoutsController < ApplicationController
  before_action :prepare_user_for_side_bar, only: :new

  def new
    @book = Book.get_book(params[:id])
    redirect_to root_path if @book.nil?
    @subscription_types = SubscriptionType.get_subscription_types
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
    
    Subscription.create_subscription(result, session[:user_id], params)
    redirect_to borrowed_books_path
  end
end
