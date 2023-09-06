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

  describe '#add_payment!' do
    context 'with an amount less than outstanding balance' do
      before do
        loan.add_payment!(1_000, Date.today)
      end

      it 'should create a payment successfully' do
        expect(loan.payments.count).to eq 5
      end

      it 'should update the outstanding balance' do
        expect(loan.reload.outstanding_balance).to eq 0
      end
    end

    context 'with an amount greather than outstanding balance' do
      it 'should not create a payment' do
        expect { loan.add_payment!(2_000, Date.today) }.not_to change { loan.payments.count }
      end

      it 'should not update the outstanding balance' do
        expect(loan.outstanding_balance).to eq 1_000
      end
    end
  end
end
