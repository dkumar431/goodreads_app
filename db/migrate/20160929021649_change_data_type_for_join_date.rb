class ChangeDataTypeForJoinDate < ActiveRecord::Migration
  def change
    change_column(:users, :join_date, :string)
  end
end
