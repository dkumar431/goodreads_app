class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :user, index: true, foreign_key: true
      t.references :book, index: true, foreign_key: true
      t.datetime :from_date
      t.datetime :to_date
      t.boolean :is_active

      t.timestamps null: false
    end
  end
end
