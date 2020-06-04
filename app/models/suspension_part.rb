class SuspensionPart < ApplicationRecord
  belongs_to :user

  VALID_TYPES = ["fork", "shock"].freeze

  validates :type, inclusion: { in: VALID_TYPES, message: "%{value} is not a valid type" }
  validates :name, presence: true
  validates :type, presence: true

  validates :high_speed_compression, inclusion: { in: [true, false], message: "%{value} must be true or false" }
  validates :low_speed_compression, inclusion: { in: [true, false], message: "%{value} must be true or false" }
  validates :high_speed_rebound, inclusion: { in: [true, false], message: "%{value} must be true or false" }
  validates :low_speed_rebound, inclusion: { in: [true, false], message: "%{value} must be true or false" }
  validates :volume, inclusion: { in: [true, false], message: "%{value} must be true or false" }
  validates :pressure, inclusion: { in: [true, false], message: "%{value} must be true or false" }
  validates :spring_rate, inclusion: { in: [true, false], message: "%{value} must be true or false" }
end
