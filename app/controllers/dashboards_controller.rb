class DashboardsController < ApplicationController
  def show
    @user = Current.user
    @bank_accounts = Current.user.bank_accounts.order(:name)
    @transactions = Current.user.transactions.order(:date)
  end
end
