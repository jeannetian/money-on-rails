require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:jeanne)
  end

  test "#index" do
    get transactions_path
    assert_response :success
  end

  test "#show" do
    get transaction_path transactions(:rent)
    assert_response :success
  end

  test "#new" do
    get new_transaction_path
    assert_response :success
  end

  test "#create" do
    assert_difference -> { users(:jeanne).transactions.count }, 1 do
      post transactions_path, params: { transaction: transaction_params }
    end

    assert_redirected_to transactions_path
  end

  test "#edit" do
    get edit_transaction_path transactions(:rent)
    assert_response :success
  end

  test "#update" do
    assert_changes -> { transactions(:rent).reload.name }, to: "Updated name" do
      patch transaction_path transactions(:rent), params: { transaction: { name: "Updated name", date: Date.current, amount: 10, bank_account_id: bank_accounts(:bnp).id } }
    end

    assert_redirected_to transactions_path
  end

  test "#destroy" do
    assert_difference -> { users(:jeanne).transactions.count }, -1 do
      delete transaction_path(transactions(:rent))
    end

    assert_redirected_to transactions_path
  end

  private

  def transaction_params
    { name: "New transaction", date: Date.current, amount: 10, bank_account_id: bank_accounts(:bnp).id }
  end
end
