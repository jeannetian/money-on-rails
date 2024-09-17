class AddBankAccountBalance < ActiveRecord::Migration[7.2]
  def change
    add_column :bank_accounts, :balance, :decimal, precision: 15, scale: 2, null: false
  end
end
