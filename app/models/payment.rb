class Payment < ApplicationRecord
  belongs_to :loan

  validates_presence_of :amount, :date
  validates_numericality_of :amount
end
