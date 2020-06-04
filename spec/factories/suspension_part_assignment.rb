FactoryBot.define do
  factory :suspension_part_assignment do
    association :bike
    association :suspension_part
    assigned_at { Time.now }
    removed_at { nil }
  end
end
