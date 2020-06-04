class Bike < ApplicationRecord
  include StateOfTheNation
  belongs_to :user
  validates :name, presence: true

  has_many :suspension_part_assignments
  has_many :suspension_parts, through: :suspension_part_assignments

  has_active :suspension_part_assignments

  def active_suspension_parts(at = Time.now)
    active_suspension_part_assignments(at).to_a.map { |assign| assign.suspension_part }
  end
end
