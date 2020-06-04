FactoryBot.define do
  factory :bike do
    association :user
    name { "transition patrol" }
  end
end
