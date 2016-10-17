class RenameTransactionIdColumn < ActiveRecord::Migration
  def change
    rename_column :transactions, :transactio_id, :transaction_id
  end
end
