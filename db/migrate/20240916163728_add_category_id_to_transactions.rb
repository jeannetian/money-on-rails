class AddCategoryIdToTransactions < ActiveRecord::Migration[7.2]
  def change
    add_reference :transactions, :category, foreign_key: true
  end
end
