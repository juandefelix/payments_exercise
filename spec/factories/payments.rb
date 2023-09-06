FactoryBot.define do
  factory :payment do
    date { Date.today }
    amount { 1_000 }
    association :loan
  end
end
