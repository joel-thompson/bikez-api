class SuspensionPartAssignment < ApplicationRecord
  include StateOfTheNation
  belongs_to :bike
  belongs_to :suspension_part
  validates :assigned_at, presence: true

  considered_active.from(:assigned_at).until(:removed_at)
end
