require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  let(:loan) { create(:loan, funded_amount: 100.0) }
  let!(:payment) { create(:payment, amount: 10.0, date: Date.today, loan: loan) }
  let(:body) { JSON.parse(response.body) }

  describe '#index' do
    before do
      get :index, params: { loan_id: loan.id }
    end

    it 'responds with a 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'contains payments attributes' do
      expect(body.first['amount']).to eq '10.00'
    end
  end

  describe '#show' do
    context 'for an existing record' do
      before do
        get :show, params: { id: payment.id }
      end

      it 'responds with a 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'contains payment attributes' do
        expect(body['amount']).to eq '10.00'
      end
    end

    context 'if the payment is not found' do
      it 'responds with a 404' do
        get :show, params: { id: 10000 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe '#create' do
    context 'with an payment amount less than the loan outstanding balance' do
      before do
        post :create, params: { loan_id: loan.id, payment_params: { amount: 50, date: Date.today } }
      end

      it 'responds with a 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'contains payments attributes' do
        expect(body['amount']).to eq '50.00'
      end
    end
  end

  context 'with an amount greather than outstanding balance' do
    before do
      post :create, params: { loan_id: loan.id, payment_params: { amount: 150_000, date: Date.today } }
    end

    it 'responds with a 422' do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'should contain errors' do
      expect(body['errors']['base']).to include "Amount exceeds loan outstanding balance"
    end
  end

  context 'with invalid attributes' do
    before do
      post :create, params: { loan_id: loan.id, payment_params: { amount: nil, date: Date.today } }
    end

    it 'responds with a 422' do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'should contain errors' do
      expect(body['errors']['amount']).to include "can't be blank"
    end
  end
end




    # it 'should update the outstanding balance' do
    #   expect(loan.reload.outstanding_balance).to eq 0
    # end
