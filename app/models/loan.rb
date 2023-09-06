class Loan < ActiveRecord::Base
  has_many :payments, -> { order(date: :asc) }

  def outstanding_balance
    funded_amount - payment_amounts
  end

  private

  def payment_amounts
    payments.sum { |payment| payment.amount }
  end
end
