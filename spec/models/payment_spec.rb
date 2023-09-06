require 'rails_helper'

RSpec.describe Payment, type: :model do
  let(:loan) { create(:loan) }

  subject { loan.payments.build(amount: 1000, date: '2023-09-06') }

  describe 'validations' do
    it { should validate_presence_of :date }
    it { should validate_numericality_of :amount }
    it { should validate_presence_of :amount }
  end
end
