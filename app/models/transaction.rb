class Transaction < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :amount

  def self.create_transaction!(transaction, user_id)
    create!({
        transaction_id: transaction.id,
        amount: transaction.amount.to_f,
        status: transaction.status,
        user_id: user_id
      })
  end
end
