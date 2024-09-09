class BankAccount < ApplicationRecord
  has_many :transactions, dependent: :destroy
  belongs_to :user

  validates :name, presence: true

  scope :ordered, -> { order(name: :asc) }
end
