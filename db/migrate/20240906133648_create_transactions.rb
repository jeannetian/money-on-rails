class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.references :bank_account, null: false, foreign_key: true
      t.date :date, null: false
      t.string :name, null: false
      t.text :description
      t.decimal :amount, null: false, precision: 15, scale: 2

      t.timestamps
    end
  end
end
