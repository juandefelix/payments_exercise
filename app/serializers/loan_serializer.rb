class LoanSerializer < ActiveModel::Serializer
  attributes :id, :funded_amount, :outstanding_balance

  def funded_amount
    "%.2f" % object.funded_amount
  end
end
