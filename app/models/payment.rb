class Payment < ApplicationRecord
  belongs_to :loan

  validates_presence_of :amount, :date
  validates_numericality_of :amount
  validate :amount_less_than_outstanding

  def amount_less_than_outstanding
    return unless amount

    errors.add(:base, 'Amount exceeds loan outstanding balance') if amount > loan.outstanding_balance
  end
end
