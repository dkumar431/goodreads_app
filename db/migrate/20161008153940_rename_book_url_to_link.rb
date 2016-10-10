class RenameBookUrlToLink < ActiveRecord::Migration
  def change
    rename_column :authors, :book_url, :link
  end
end
