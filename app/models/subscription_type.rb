class SubscriptionType < ActiveRecord::Base

    scope :get_all, -> { self.select('id, days, cost') }

  def self.get_subscription_types
      @all ||= get_all 
  end

  def self.get_subscribed_days(sub_id)
    where(id: sub_id).first.days
  end
end
