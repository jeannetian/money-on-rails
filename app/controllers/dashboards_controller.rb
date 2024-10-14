class DashboardsController < ApplicationController
  def show
    @bank_accounts = Current.user.bank_accounts.order(:name)
    @transactions = Current.user.transactions.order(:date)
    @total_by_category = Current.user.transactions.left_joins(:category).group(:category).sum(:amount)
  end
end
