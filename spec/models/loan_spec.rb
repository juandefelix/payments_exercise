require 'rails_helper'

RSpec.describe Loan, type: :model do
  let(:loan) { create :loan, funded_amount: 5_000 }

  before do
    (1..4).each do |day|
      create(:payment, amount: 1_000, date: day.days.ago, loan: loan)
    end
  end

  describe '#outstanding_balance' do
    it 'should subtract amount from any payment' do
      expect(loan.reload.outstanding_balance.to_i).to eq 1_000
    end
  end
end
