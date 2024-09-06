require "test_helper"

class BankAccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:jeanne)
  end

  test "#index" do
    get bank_accounts_path
    assert_response :success
  end

  test "#show" do
    get bank_account_path bank_accounts(:bnp)
    assert_response :success
  end

  test "#new" do
    get new_bank_account_path
    assert_response :success
  end

  test "#create" do
    assert_difference -> { users(:jeanne).bank_accounts.count }, 1 do
      post bank_accounts_path, params: { bank_account: { name: "New bank account" } }, as: :turbo_stream
    end

    assert_turbo_stream action: :append, target: "bank_accounts"
  end

  test "#edit" do
    get edit_bank_account_path bank_accounts(:bnp)
    assert_response :success
  end

  test "#update" do
    assert_changes -> { bank_accounts(:bnp).reload.name }, to: "Updated name" do
      patch bank_account_path bank_accounts(:bnp), params: { bank_account: { name: "Updated name" } }
    end

    assert_redirected_to bank_accounts_path
  end

  test "#destroy" do
    assert_difference -> { users(:jeanne).bank_accounts.count }, -1 do
      delete bank_account_path(bank_accounts(:bnp)), as: :turbo_stream
    end

    assert_turbo_stream action: :remove, target: bank_accounts(:bnp)
  end
end
