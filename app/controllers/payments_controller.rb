class PaymentsController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  before_action :find_loan, only: [:index, :create]

  def create
    payment = @loan.payments.build(payment_params)

    if payment.save
      render json: payment
    else
      render json: { errors: payment.errors }, status: 422
    end
  end

  def index
    render json: @loan.payments
  end

  def show
    render json: Payment.find(params[:id])
  end

  private

  def find_loan
    @loan = Loan.find(params[:loan_id])
  end

  def payment_params
    params.require(:payment_params).permit(:amount, :date)
  end
end
