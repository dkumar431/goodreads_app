class AddSubscriptionTypeIdToSubscription < ActiveRecord::Migration
  def change
    add_reference :subscriptions, :subscription_types, index: true
  end
end
