require "test_helper"

class TransactionTest < ActiveSupport::TestCase
  test "#recording a transaction updates the balance" do
    transaction = Transaction.new(amount: 100, bank_account: bank_accounts(:bnp), name: "Recorded transaction", date: Date.current)

    assert_difference -> { bank_accounts(:bnp).balance }, 100 do
      transaction.record
    end
  end

  test "#changing a transaction amount within the same bank account updates the balance" do
    assert_difference -> { bank_accounts(:bnp).reload.balance }, 100 do
      transactions(:rent).change(amount: -900)
    end
  end

  test "#changing a transaction amount and bank account updates the balances" do
    assert_difference -> { bank_accounts(:bnp).reload.balance }, 1000 do
      assert_difference -> { bank_accounts(:citibank).reload.balance }, -900 do
        transactions(:rent).change(amount: -900, bank_account: bank_accounts(:citibank))
      end
    end
  end

  test "#changing a transaction name does not update the balance" do
    assert_no_difference -> { bank_accounts(:bnp).reload.balance } do
      assert_changes -> { transactions(:rent).reload.name }, "Changed name" do
        transactions(:rent).change(name: "Changed name")
      end
    end
  end

  test "#removing a transaction updates the balance" do
    assert_difference -> { bank_accounts(:bnp).reload.balance }, - transactions(:rent).amount do
      transactions(:rent).remove
    end
  end
end
