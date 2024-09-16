class User < ApplicationRecord
  has_secure_password

  has_many :sessions, dependent: :destroy
  has_many :bank_accounts, dependent: :destroy
  has_many :transactions, through: :bank_accounts
  has_many :categories, dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }

  normalizes :email, with: ->(email) { email.strip.downcase }
end
