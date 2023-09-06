class PaymentSerializer < ActiveModel::Serializer
  attributes :id, :amount, :date

  def amount
    "%.2f" % object.amount
  end
end
