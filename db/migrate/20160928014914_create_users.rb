class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.bigint :goodreads_user_id
      t.string :name
      t.string :img_url
      t.string :address
      t.date :join_date
      t.string :gender

      t.timestamps null: false
    end
  end
end
