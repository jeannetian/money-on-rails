class Transaction < ApplicationRecord
  belongs_to :bank_account
  belongs_to :category, optional: true

  validates :date, :name, :amount, presence: true

  def record
    return false unless valid?

    transaction do
      bank_account.update!(balance: bank_account.balance + amount)
      save!
    end
  end

  def change(attributes)
    previous_bank_account = bank_account
    assign_attributes(attributes)
    new_bank_account = bank_account

    return false unless valid?

    transaction do
      previous_bank_account.update!(balance: previous_bank_account.balance - amount_was)
      new_bank_account.update!(balance: new_bank_account.balance + amount)
      save!
    end
  end

  def remove
    transaction do
      bank_account.update!(balance: bank_account.balance - amount)
      destroy!
    end
  end
end
