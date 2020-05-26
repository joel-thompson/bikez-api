FactoryBot.define do
  factory :post do
    association :user
    title { "foo" }
  end
end
