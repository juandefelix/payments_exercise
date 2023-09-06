class Loan < ActiveRecord::Base
  has_many :payments, -> { order(date: :asc) }

  def outstanding_balance
    funded_amount - payment_amounts
  end

  def add_payment!(amount, date)
    return false if amount > outstanding_balance

    Payment.create(amount: amount, date: date, loan: self)
  end

  private

  def payment_amounts
    payments.sum { |payment| payment.amount }
  end
end
