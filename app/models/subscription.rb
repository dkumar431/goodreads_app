class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  def self.create_subscription(tran_res, user_id, sub_details)
    begin 
      ActiveRecord::Base.transaction do
        Subscription.create!(subscription_params(sub_details, user_id))
        Transaction.create_transaction!(tran_res.transaction, user_id)
    rescue exception => e
      Rails.logger.info e.message
    end
  end

  private
  def self.subscription_params(sub_details, user_id)
    {
        user_id: user_id,
        book_id: sub_details[:book_id],
        subscription_types_id: sub_details[:sub_type_id],
        from_date: start_date,
        to_date: get_end_date(sub_details),
        is_active: true
      }
  end

  def get_end_date(sub_details)
    start_date = Date.parse(sub_details[:sub_start_date])
    no_of_days = SubscriptionType.get_subscribed_days(sub_details[:subscription_type_id])
    start_date + no_of_days
  end
end
