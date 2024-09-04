class BankAccountsController < ApplicationController
  before_action :set_bank_account, only: %i[ show edit update destroy ]

  def index
    @bank_accounts = Current.user.bank_accounts
  end

  def show
  end

  def new
    @bank_account = Current.user.bank_accounts.build
  end

  def create
    @bank_account = Current.user.bank_accounts.build(bank_account_params)

    if @bank_account.save
      redirect_to bank_accounts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @bank_account.update(bank_account_params)
      redirect_to bank_accounts_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @bank_account.destroy!
    redirect_to bank_accounts_path
  end

  private
    def bank_account_params
      params.require(:bank_account).permit(:name)
    end

    def set_bank_account
      @bank_account = Current.user.bank_accounts.find(params[:id])
    end
end
