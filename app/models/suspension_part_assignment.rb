class SuspensionPartAssignment < ApplicationRecord
  belongs_to :bike
  belongs_to :suspension_part
  validates :assigned_at, presence: true
end
