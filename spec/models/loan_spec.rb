require 'rails_helper'

RSpec.describe Loan, type: :model do
  let(:loan) { create :loan, funded_amount: 5_000 }

  before do
    create_list(:payment, 4, amount: 1_000, loan: loan)
  end

  describe '#outstanding_balance' do
    it 'should subtract amount from any payment' do
      expect(loan.outstanding_balance.to_i).to eq 1_000
    end
  end
end
