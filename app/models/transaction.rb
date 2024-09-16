class Transaction < ApplicationRecord
  belongs_to :bank_account

  validates :date, :name, :amount, presence: true
end
