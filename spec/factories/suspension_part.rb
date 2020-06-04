FactoryBot.define do
  factory :suspension_part do
    association :user
    name { "fox 36" }
    type { "fork" }
    high_speed_compression { true }
    low_speed_compression { true }
    high_speed_rebound { true }
    low_speed_rebound { true }
    volume { true }
    pressure { true }
    spring_rate { false }
  end
end
