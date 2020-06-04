class Bike < ApplicationRecord
  include StateOfTheNation
  belongs_to :user
  validates :name, presence: true

  has_many :suspension_part_assignments
  has_many :suspension_parts, through: :suspension_part_assignments

  has_active :suspension_part_assignments
end
