class IncreaseDescriptionLength < ActiveRecord::Migration
  def change
    change_column :books, :description, :string, :limit => 3000
  end
end
