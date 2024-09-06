class Transaction < ApplicationRecord
  belongs_to :bank_account

  validates :date, presence: true
  validates :name, presence: true
  validates :amount, presence: true
end
