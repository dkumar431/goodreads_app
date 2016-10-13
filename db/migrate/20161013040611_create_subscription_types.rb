class CreateSubscriptionTypes < ActiveRecord::Migration
  def change
    create_table :subscription_types do |t|
      t.integer :days
      t.integer :cost

      t.timestamps null: false
    end
  end
end
