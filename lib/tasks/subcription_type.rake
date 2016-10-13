namespace :subcription_type do
  desc "Creating new subscription types"
  task create: :environment do
    SubscriptionType.create({days: 7, cost: 20})
    SubscriptionType.create({days: 15, cost: 35})
    SubscriptionType.create({days: 30, cost: 50})
  end

end
