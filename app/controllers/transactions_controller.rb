class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy ]

  def index
    @transactions = Current.user.transactions
  end

  def show
  end

  def new
    @transaction = Current.user.transactions.build
  end

  def create
    @transaction = Current.user.transactions.build(transaction_params)

    if @transaction.record
      redirect_to transactions_path
    else
      render "new", status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @transaction.change(transaction_params)
      redirect_to transactions_path
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    @transaction.remove

    redirect_to transactions_path
  end

  private
    def transaction_params
      params.require(:transaction).permit(:date, :name, :description, :amount)
        .merge(bank_account: bank_account)
        .merge(category: category)
    end

    def bank_account
      Current.user.bank_accounts.find_by(id: params.dig(:transaction, :bank_account_id))
    end

    def category
      Current.user.categories.find_by(id: params.dig(:transaction, :category_id))
    end

    def set_transaction
      @transaction = Current.user.transactions.find(params[:id])
    end
end
