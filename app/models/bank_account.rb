class BankAccount < ApplicationRecord
  belongs_to :user

  validates :name, presence: true

  scope :ordered, -> { order(name: :asc) }
end
