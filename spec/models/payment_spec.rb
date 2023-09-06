require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe 'validations' do
    it { should validate_presence_of :amount }
    it { should validate_presence_of :date }
    it { should validate_numericality_of :amount }
  end
end
